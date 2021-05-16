from __future__ import division, print_function
from flask import Flask, request, redirect, jsonify
from firebase_admin import credentials, firestore, initialize_app
import numpy as np
import pandas as pd
import os
import collections
import string
import tweepy
import csv, json
import re
import nltk
from nltk.corpus import stopwords
from nltk import word_tokenize, WordNetLemmatizer
from nltk.corpus import stopwords
from textblob import TextBlob
from keras.models import load_model
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.stem import WordNetLemmatizer

tfidf = TfidfVectorizer(max_features=500)
wnl = WordNetLemmatizer()

app = Flask(__name__)

# Initialize Firestore DB
cred = credentials.Certificate('key.json')
default_app = initialize_app(cred)
db = firestore.client()

#Twitter API credentials
consumer_key = "4xHhtirZfM5ejlT5ecQKVGhgv"
consumer_secret = "iVkSlSYKQHCTYKls57cbKd9yPQJVup3f35LgMT8ZekTnAz5hlZ"
access_key = "1090237519634022403-nJk1suG9nwO3ShpialOU1vAQdYecrS"
access_secret = "DgneEiyAGdtuo9Bsr9iN6l9OWMx8Y78VtKaSqwh5vDFt2"
stoplist = stopwords.words('english')

#-----------------FUNCTIONS------------------------

def get_all_tweets(screen_name):
    #Twitter only allows access to a users most recent 3240 tweets with this method
    
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_key, access_secret)
    api = tweepy.API(auth)
    
    alltweets = []  
    
    new_tweets = api.user_timeline(screen_name = screen_name, count=200)
    
    alltweets.extend(new_tweets)
    
    oldest = alltweets[-1].id - 1
    
    while len(new_tweets) > 0:
        print(f"getting tweets before {oldest}")
        
        new_tweets = api.user_timeline(screen_name = screen_name,count=200,max_id=oldest)
        
        alltweets.extend(new_tweets)
        
        oldest = alltweets[-1].id - 1
        
        print(f"...{len(alltweets)} tweets downloaded so far")
    
    outtweets = [[tweet.id_str, tweet.created_at, tweet.text] for tweet in alltweets]

    with open(f'{screen_name}_tweets.csv', 'wt', encoding='utf-8') as out_file:
        csv_writer = csv.writer(out_file, delimiter = '\t')
        csv_writer.writerows(outtweets)
    return outtweets


def cleanText(text):
    text = re.sub(r'@[A-Za-z0-9]+', '', text) # @mentions
    text = re.sub('@[^\s]+', 'AT_USER', text) # remove usernames
    text = re.sub('['+string.punctuation+']', '', text) # remove punctuations
    text = re.sub('(?<=[a-z])\'(?=[a-z])', '', text) # remove apostrophe
    text = text.strip("â€™")
    text = text.strip("â€œ")
    text = text.strip("â€")
    text = re.sub(r'RT[\s]+', '', text) # removeRT
    text = re.compile(u'([\U00002600-\U000027BF])|([\U0001f300-\U0001f64F])|([\U0001f680-\U0001f6FF])').sub(r'', text)
    text = re.sub(r'^https?:\/\/.*[\r\n]*', '', text) # remove hyperlink
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


def getSubjectivity(text):
  return TextBlob(text).sentiment.subjectivity


def getPolarity(text):
  return TextBlob(text).sentiment.polarity

def predict_tweets(tweets):
  tweets = re.sub(pattern='[^a-zA-Z]',repl=' ', string = tweets)
  tweets = tweets.lower()
  tweets_words = tweets.split()
  tweets_words = [word for word in tweets_words if not word in set(stopwords.words('english'))]
  final_tweets = [wnl.lemmatize(word) for word in tweets_words]
  final_tweets = ' '.join(final_tweets)
  model = load_model('/content/CNN_model.h5', compile=True)
  temp = tfidf.transform([final_tweets]).toarray()
  return model.predict(temp)


@app.route('/', methods = ['GET'])
def home():
   return jsonify('Hello! Tweet Analysis')


@app.route('/tweets', methods = ['POST'])
def tweets():
    response = request.get_json()
    print("Response", response)
    username = response['username']
    user_id = response['user_id']
    print("Username: " + username)
    print("User ID: " + user_id)

    get_all_tweets(username)
    
    data = pd.read_csv(f'{username}_tweets.csv', header = None, delimiter='\t')
    data.columns = ['id', 'created_at', 'Tweets']
    data['Tweets'] = data['Tweets'].apply(cleanText)

    tokens = [word_tokenize(sen) for sen in data.Tweets] 

    lower_tokens = [lower_token(token) for token in tokens]

    filtered_words = [remove_stop_words(sen) for sen in lower_tokens]

    result = [' '.join(sen) for sen in filtered_words]

    data['Tweets_final'] = result
    data['tokens'] = filtered_words

    data['Subjectivity'] = data['Tweets_final'].apply(getSubjectivity)
    data['Polarity'] = data['Tweets_final'].apply(getPolarity)

    label = []

    for score in data.Polarity:
        if score < 0:
            label.append(-1)
        elif score == 0:
            label.append(0)
        else:
            label.append(1)

    data['Label'] = label

    df = pd.DataFrame(label, columns=['labelname'])
    print(df.shape)
    
    labelval = df['labelname'].value_counts() #count label values

    total = labelval.sum()

    percent = (labelval / labelval.sum()) * 100 #calculate percentage (daily)
    print(percent)

    # output = predict_tweets(tweets)

    doc_ref = db.collection(u'results').document(username)
    result = {
        u'neutral': percent.values[1],
        u'positive': percent.values[2],
        u'negative': percent.values[0]
    }
    timestamp = firestore.SERVER_TIMESTAMP
    final = {
        u'user_id': user_id,
        u'username': username,
        u'result': result,
        u'timestamp': timestamp
    }

    doc_ref.set(final)

    print('Successfully fetched ' + username + ' Twitter data!')

    return jsonify({
        # 'username': username,
        'status': 'Success',
    })


@app.after_request
def add_headers(response):
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add("Access-Control-Allow-Headers", "Content-Type,Authorization")
    return response


if __name__ == '__main__':
   app.run(debug=True)
