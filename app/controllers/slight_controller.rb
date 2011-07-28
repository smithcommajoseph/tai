class SlightController < ApplicationController
  
  def generator
    noun = InsultNoun.first(:offset => rand(InsultNoun.count)).noun
    adjective = InsultAdjective.first(:offset => rand(InsultAdjective.count)).adjective
    insult = "#{adjective} #{noun}"
    t = flash[:t]
    tweet = Tweet.create()
    tweet.t = t
    tweet.insult = insult
    tweet.to = ''
    @tweet = tweet
    
    twitter_account = TwitterAccount.find_by_oauth_token(@t)
  end
  
  def success
    
  end
  
end
