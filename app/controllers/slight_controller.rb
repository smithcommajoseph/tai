class SlightController < ApplicationController
  
  def generator
    @t = flash.t
  end
  
  def whom
    # twitter_account = TwitterAccount.find_by_oauth_token(params[:oauth_token])
    # twitter_account.post('@deanboyer, would ya look at it?');
    
  end
  
  def tweet
    
  end
  
end
