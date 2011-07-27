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
        flash[:notice] = 'Twitter account activated!'
        redirect_to(twitter_account.post('Dude, ignore this post, im testing some shiz.'));
      else
        flash[:notice] = "Unable to activate twitter account."
      end
    end
  end
  
end
