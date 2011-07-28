class TwitterAccountsController < ApplicationController
  
  def new
    twitter_account = TwitterAccount.create()
    redirect_to(twitter_account.authorize_url(twitter_callback_url))
  end
  
  def callback
    if params[:denied] && !params[:denied].empty?
      # redirect_to(deals_url, :alert => 'Unable to connect with twitter: #{parms[:denied]}')
    else
      twitter_account = TwitterAccount.find_by_oauth_token(params[:oauth_token])
      twitter_account.validate_oauth_token(params[:oauth_verifier], twitter_callback_url)
      twitter_account.save
      if twitter_account.active?
        redirect_to(slight_generator_url, :notice => 'Twitter account activated!', flash[:t]=> params[:oauth_token])
        
        # flash[:notice] = 'Twitter account activated!'
        # twitter_account.post('@deanboyer, would ya look at it?');
      else
        flash[:notice] = "Unable to activate twitter account."
      end
    end
  end
  
end
