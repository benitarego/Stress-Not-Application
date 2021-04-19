from __future__ import division, print_function
from flask import Flask, redirect, jsonify
from keras.callbacks import ModelCheckpoint
from keras.layers import Dense, Dropout, Reshape, Flatten, concatenate, Input, Conv1D, GlobalMaxPooling1D, Embedding
from keras.layers.recurrent import LSTM
from keras.models import Sequential
from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.models import Model
import numpy as np
import pandas as pd
import os
import collections
import string
import tweepy
import csv, json
import re
import nltk
# from nltk import word_tokenize, WordNetLemmatizer
from nltk.corpus import stopwords
# import matplotlib.pyplot as plt

app = Flask(__name__)
#Twitter API credentials
consumer_key = "9b8smdO0UloxZojzQ3Eh4zR7e"
consumer_secret = "MhmYPAiSSeoThxzvGtpSfwEQKuklKbDkQeen9q2Wrsb9bJjhJL"
access_key = "1090237519634022403-BekeYJMQYPQBoFK1nKlxKkgokGvB9D"
access_secret = "ycvQYN9SWilyk6teB9RBr08eJ9dckTEaxWI6ZmMZUVl8q"

stoplist = stopwords.words('english')

#-----------------FUNCTIONS------------------------

def get_all_tweets(screen_name):
    #Twitter only allows access to a users most recent 3240 tweets with this method
    
    #authorize twitter, initialize tweepy
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_key, access_secret)
    api = tweepy.API(auth)
    
    #initialize a list to hold all the tweepy Tweets
    alltweets = []  
    
    #make initial request for most recent tweets (200 is the maximum allowed count)
    new_tweets = api.user_timeline(screen_name = screen_name, count=200)
    
    #save most recent tweets
    alltweets.extend(new_tweets)
    
    #save the id of the oldest tweet less one
    oldest = alltweets[-1].id - 1
    
    #keep grabbing tweets until there are no tweets left to grab
    while len(new_tweets) > 0:
        print(f"getting tweets before {oldest}")
        
        #all subsiquent requests use the max_id param to prevent duplicates
        new_tweets = api.user_timeline(screen_name = screen_name,count=200,max_id=oldest)
        
        #save most recent tweets
        alltweets.extend(new_tweets)
        
        #update the id of the oldest tweet less one
        oldest = alltweets[-1].id - 1
        
        print(f"...{len(alltweets)} tweets downloaded so far")
    
    #transform the tweepy tweets into a 2D array that will populate the csv 
    outtweets = [[tweet.id_str, tweet.created_at, tweet.text] for tweet in alltweets]

    #write the csv
    with open(f'D:/projects/stress_detector/ML/new_{screen_name}_tweets.csv', 'wt', encoding='utf-8') as out_file:
        csv_writer = csv.writer(out_file, delimiter = '\t')
        # csv_writer.writerow(["id","created_at","tweets"])
        csv_writer.writerows(outtweets)
    return outtweets
    # pass

def cleanText(text):
    text = re.sub(r'@[A-Za-z0-9]+', '', text) # @mentions
    text = re.sub('@[^\s]+', 'AT_USER', text) # remove usernames
    text = re.sub('['+string.punctuation+']', '', text) # remove punctuations
    text = re.sub(r'RT[\s]+', '', text) # removeRT
    text = re.compile(u'([\U00002600-\U000027BF])|([\U0001f300-\U0001f64F])|([\U0001f680-\U0001f6FF])').sub(r'', text)
    text = re.sub(r'https?:\/\/\S+', '', text) # remove hyperlink
    return text

def lower_token(tokens): 
    return [w.lower() for w in tokens]   

def remove_stop_words(tokens): 
    return [word for word in tokens if word not in stoplist]

def get_average_word2vec(tokens_list, vector, generate_missing=False, k=300):
    if len(tokens_list)<1:
        return np.zeros(k)
    if generate_missing:
        vectorized = [vector[word] if word in vector else np.random.rand(k) for word in tokens_list]
    else:
        vectorized = [vector[word] if word in vector else np.zeros(k) for word in tokens_list]
    length = len(vectorized)
    summed = np.sum(vectorized, axis=0)
    averaged = np.divide(summed, length)
    return averaged

def get_word2vec_embeddings(vectors, clean_comments, generate_missing=False):
    embeddings = clean_comments['tokens'].apply(lambda x: get_average_word2vec(x, vectors, generate_missing=generate_missing))
    return list(embeddings)

@app.route('/', methods = ['GET'])
def home():
   return jsonify('Hello! Tweet Analysis')

@app.route('/tweets', methods = ['GET'])
def tweets():
    # user_name = request.body.user_name
    # user_name = request.get_json()['user_name']
    user_name = input("Enter twitter username: ")
    outtweets = get_all_tweets(user_name) #remove await
    print('Successfully fetched ' + user_name + ' Twitter data!')
    numpy_outtweets = np.array(outtweets)
    data = pd.DataFrame(numpy_outtweets, columns=['id', 'created_at', 'Tweets'])
    # data = pd.read_csv(f'new_{user_name}_tweets.csv', header = None, delimiter='\t')
    # data.columns = ['id', 'created_at', 'Tweets']
    data['Tweets'] = data['Tweets'].apply(cleanText)
    print("twitter data is cleaned")

    result = data.to_json(r"D:/projects/stress_detector/ML/regobenita.json", indent=4)
    print("Data Saved")

    tokens = [word_tokenize(sen) for sen in data.Tweets] 

    lower_tokens = [lower_token(token) for token in tokens]

    filtered_words = [remove_stop_words(sen) for sen in lower_tokens]

    result = [' '.join(sen) for sen in filtered_words]

    data['Tweets_final'] = result
    data['tokens'] = filtered_words

    all_words = [word for tokens in data["tokens"] for word in tokens]
    sentence_lengths = [len(tokens) for tokens in data["tokens"]]
    VOCAB = sorted(list(set(all_words)))

    word2vec_path = 'D:\projects\stress_detector\api\GoogleNews-vectors-negative300.bin'
    word2vec = models.KeyedVectors.load_word2vec_format(word2vec_path, binary=True)

    # get embeddings
    embeddings = get_word2vec_embeddings(word2vec, data, generate_missing=True)
    MAX_SEQUENCE_LENGTH = 50
    EMBEDDING_DIM = 300

    # tokenizing and padding sequences
    tokenizer = Tokenizer(num_words=len(VOCAB), lower=True, char_level=False)
    tokenizer.fit_on_texts(data["Tweets_final"].tolist())
    training_sequences = tokenizer.texts_to_sequences(data["Tweets_final"].tolist())

    word_index = tokenizer.word_index

    cnn_data = pad_sequences(training_sequences, maxlen=MAX_SEQUENCE_LENGTH)

    embedding_weights = np.zeros((len(word_index)+1, EMBEDDING_DIM))
    for word,index in word_index.items():
        embedding_weights[index,:] = word2vec[word] if word in word2vec else np.random.rand(EMBEDDING_DIM)
    print(embedding_weights.shape)

    x_values = cnn_data

    #load model
    model = load_model('D:\projects\stress_detector\api\CNN_model.h5', compile=True)

    model.predict(x_values)

    # Here all the code to get the output in UI (Graph)
    # .
    # .

    return jsonify({
        'user_name': user_name,
        'status': 'Success',
        # 'no_of_tweets': 
        # 'stats': {
        #     'positive_tweets': ,
        #     'negative_tweets': ,
        # }
    })

@app.after_request
def add_headers(response):
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add("Access-Control-Allow-Headers", "Content-Type,Authorization")
    return response

if __name__ == '__main__':
   app.run(debug=True)