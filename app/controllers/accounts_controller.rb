class AccountsController < ApplicationController
  
  def new
    twitter_account = Account.create()
    redirect_to(twitter_account.twitter_authorize_url(twitter_callback_url))
  end
  
  def twitter_callback
    if params[:denied] && !params[:denied].empty?
      # redirect_to(deals_url, :alert => 'Unable to connect with twitter: #{parms[:denied]}')
    else
      twitter_account = Account.find_by_oauth_token(params[:oauth_token])
      twitter_account.twitter_validate_oauth_token(params[:oauth_verifier], twitter_callback_url)
      twitter_account.save
      if twitter_account.active?
        redirect_to(new_tweet_url, :notice => 'Twitter account activated!', :flash => {:t => twitter_account.oauth_token})
      else
        flash[:notice] = "Unable to activate twitter account."
      end
    end
  end
  
end
