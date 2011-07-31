class AccountsController < ApplicationController
  
  def new
    account = Account.create()
    
    if(params[:network] === 'fb')
      redirect_to(account.fb_authorize_url(facebook_callback_url(:id => account.id)))      
    else
      redirect_to(account.twitter_authorize_url(twitter_callback_url))
    end
  end
  
  def twitter_callback
    if params[:denied] && !params[:denied].empty?
      redirect_to(network_choice_url, :alert => 'Unable to connect with twitter: #{parms[:denied]}')
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
  
  def fb_callback
    if params[:error_reason] && !params[:error_reason].empty?
      # We have a problem!
      redirect_to(network_choice_url :notice => "Unable to activate facebook: #{params[:error_reason]}")
    elsif params[:code] && !params[:code].empty?
      # This is the callback, we have an id and an access code
      facebook_account = Account.find(params[:id])
      facebook_account.fb_validate_oauth_token(params[:code], facebook_callback_url(:id => facebook_account.id))
      redirect_to(new_tweet_url, :notice => 'Facebook account activated!', :flash => {:t => facebook_account.oauth_token})
    end
  end
end
