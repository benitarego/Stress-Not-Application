import tweepy
import requests
import json
import sys
import time
import random

auth = tweepy.OAuthHandler("IXo5uEathVAM3NIQcsYTioDTY", "rSfXe1a3Qk1V9B3DSrbcVJZrH402FLWvjsbiFQ9BvJ0MxWMJV6")
auth.set_access_token("1090237519634022403-zelXU9FpzGCaFlnzR1Id96THCxUo4D", "RyRb5ZHko1Uwhv8QZcafUtBUBAZdLKrtUP6Mbmh24tRKG")
api = tweepy.API(auth)

fb_url = https://{yourfirebaseappname}.firebaseio.com/tweets.json