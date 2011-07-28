class SlightController < ApplicationController
  
  def generator
    
  end
  
  def whom
    twitter_account = TwitterAccount.find_by_oauth_token(params[:oauth_token])
    twitter_account.post('@deanboyer, would ya look at it?');
    
  end
  
  def tweet
    
  end
  
end
