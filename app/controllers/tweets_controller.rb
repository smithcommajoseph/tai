class TweetsController < ApplicationController
  
  def new
    noun = InsultNoun.first(:offset => rand(InsultNoun.count)).noun
    adjective = InsultAdjective.first(:offset => rand(InsultAdjective.count)).adjective
    insult = "#{adjective} #{noun}"
    t = flash[:t]
    
    @tweet = Tweet.new({:t => t, :insult => insult})
  end
  
  def create
    @tweet = Tweet.create(params[:tweet])
    if @tweet.valid?
      twitter_account = Account.find_by_oauth_token(@tweet.t)
      twitter_account.twitter_post("#{@tweet.to} is a #{@tweet.insult} #tweetaninsult")
      flash[:notice] = "Sweet! You successfully (and publicly) bashed that no good #{@tweet.to} proper!"
      redirect_to :action => 'show', :id => @tweet.id
    else
      render :action => 'new', :notice => 'Need to fill out all the fields, ya douche!'
    end
  end
  
  def show
    @tweet = Tweet.find(params[:id])
    @sent = "@#{@tweet.to} is a #{@tweet.insult} #tweetaninsult"
  end
  
end
