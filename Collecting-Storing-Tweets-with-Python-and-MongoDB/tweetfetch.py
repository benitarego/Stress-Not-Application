import tweepy
import requests
import json
import sys
import time
import random

auth = tweepy.OAuthHandler("xxxxxxxxxxxxxxxxxxxxxxxx", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
auth.set_access_token("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
api = tweepy.API(auth)

fb_url = https://{yourfirebaseappname}.firebaseio.com/tweets.json
