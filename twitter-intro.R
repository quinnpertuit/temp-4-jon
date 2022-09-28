setwd('C:/Users/jon/Documents/R/twitter')

library(tidyverse)
library(rtweet)

# Set up Twitter API (only needs to be done once).
auth_setup_default()

# Load Twitter API credentials.
token = auth_get()

# Enter keyword to search on Twitter .
keyword = 'web3'

# Search tweets (set n = the number of tweets you want to pull).
raw = search_tweets(q = keyword, n = 5, lang = "en", include_rts=FALSE, type='recent', token = token)

# Tweets: Select the fields in the tweet data you want.
tweets = raw %>% 
  select(time = created_at, id = id_str, tweet = full_text, source, likes = favorite_count, replies = reply_count, rts = retweet_count)

# Users: Get the user data for those tweets.
users = users_data(raw) %>% 
  select(user = screen_name, verified, bio = description, tweets = statuses_count, followers = followers_count)

# Combine: Create final dataset.
data = bind_cols(users, tweets)

# Print / Preview the final dataset (view the first 5 rows).
data %>% head(5)

# Write to csv / excel file.
file_name = paste(Sys.Date(), '-', keyword, '.csv')
write_csv(data, file_name)
