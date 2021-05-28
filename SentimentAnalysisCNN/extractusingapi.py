import tweepy

# Your Twittter App Credentials
consumer_key = "IXo5uEathVAM3NIQcsYTioDTY"
consumer_secret = "rSfXe1a3Qk1V9B3DSrbcVJZrH402FLWvjsbiFQ9BvJ0MxWMJV6"
access_key = "1090237519634022403-zelXU9FpzGCaFlnzR1Id96THCxUo4D"
access_secret = "RyRb5ZHko1Uwhv8QZcafUtBUBAZdLKrtUP6Mbmh24tRKG"

# Function to extract tweets 
def get_tweets(username): 
          
        # Authorization to consumer key and consumer secret 
        auth = tweepy.OAuthHandler(consumer_key, consumer_secret) 
  
        # Access to user's access key and access secret 
        auth.set_access_token(access_key, access_secret) 
  
        # Calling api 
        api = tweepy.API(auth) 
  
        # Extracting 200 tweets
        number_of_tweets=200
        tweets = api.user_timeline(screen_name=username) 
  
        # Empty Array 
        tmp=[]  
  
        # create array of tweet information: username, tweet id, date/time, text 
        tweets_for_csv = [tweet.text for tweet in tweets] # CSV file created  
        for j in tweets_for_csv: 
  
            # Appending tweets to the empty array tmp 
            tmp.append(j)  
  
        # Printing the tweets 
        print(tmp)

if __name__ == '__main__':
	#pass in the username of the account you want to download
    get_tweets("MumbaiPolice")