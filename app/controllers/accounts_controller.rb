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
      # We have a problem!
      redirect_to(network_choice_url, :alert => "Unable to connect with Twitter: #{parms[:denied]}")
    else
      # This is the callback, we have an id and an access code
      twitter_account = Account.find_by_oauth_token(params[:oauth_token])
      twitter_account.twitter_validate_oauth_token(params[:oauth_verifier], twitter_callback_url)
      if twitter_account.active?
        redirect_to account_interstitial_url(:t => twitter_account.oauth_token, :n => 'twitter')
      else
        flash[:notice] = "Unable to activate Twitter account."
      end
    end
  end
  
  def fb_callback
    if params[:error_reason] && !params[:error_reason].empty?
      # We have a problem!
      redirect_to(network_choice_url :notice => "Unable to activate Facebook: #{params[:error_reason]}")
    elsif params[:code] && !params[:code].empty?
      # This is the callback, we have an id and an access code
      facebook_account = Account.find(params[:id])
      facebook_account.fb_validate_oauth_token(params[:code], facebook_callback_url(:id => facebook_account.id))
      if facebook_account.active?
        redirect_to account_interstitial_url(:t => facebook_account.oauth_token, :n => 'fb')
      else
        flash[:notice] = "Unable to activate Facebook account."
      end
    end
  end
  
  def interstitial
    render :layout => 'interstitial'
    flash[:notice] = 'Account activated!' 
    flash[:t] = params[:t] 
    flash[:n] = params[:n]
  end
end
