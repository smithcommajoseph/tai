class Account < ActiveRecord::Base
  
  CONSUMER_KEY = APP_CONFIG[:twitter][:consumer_key]
  CONSUMER_SECRET = APP_CONFIG[:twitter][:consumer_secret]
  OPTIONS = {:site => "http://api.twitter.com", :request_endpoint => "https://api.twitter.com/oauth/request_token"}
  
  FACEBOOK_CLIENT_ID = APP_CONFIG[:facebook][:consumer_key]
  FACEBOOK_CLIENT_SECRET = APP_CONFIG[:facebook][:consumer_secret]
  
  def twitter_authorize_url(callback_url = '')
    if self.oauth_authorize_url.blank?
      # Step one, generate a request URL with a request token and secret
      signing_consumer = OAuth::Consumer.new(Account::CONSUMER_KEY, Account::CONSUMER_SECRET, Account::OPTIONS)
      request_token = signing_consumer.get_request_token(:oauth_callback => callback_url)
      self.oauth_token = request_token.token
      self.oauth_token_secret = request_token.secret
      self.oauth_authorize_url = request_token.authorize_url
      self.save!
    end
    self.oauth_authorize_url
  end
  
  def twitter_validate_oauth_token(oauth_verifier, callback_url = '')
    begin
      signing_consumer = OAuth::Consumer.new(Account::CONSUMER_KEY, Account::CONSUMER_SECRET, Account::OPTIONS)
      access_token = OAuth::RequestToken.new(signing_consumer, self.oauth_token, self.oauth_token_secret).
                                         get_access_token(:oauth_verifier => oauth_verifier)
      self.oauth_token = access_token.params[:oauth_token]
      self.oauth_token_secret = access_token.params[:oauth_token_secret]
      self.stream_url = "http://twitter.com/#{access_token.params[:screen_name]}"
      self.active = true
    rescue OAuth::Unauthorized
      self.errors.add(:oauth_token, "Invalid OAuth token, unable to connect to twitter")
      self.active = false
    end
    self.save!
  end
  
  def twitter_post(message)
    Twitter.configure do |config|
      config.consumer_key = Account::CONSUMER_KEY
      config.consumer_secret = Account::CONSUMER_SECRET
      config.oauth_token = self.oauth_token
      config.oauth_token_secret = self.oauth_token_secret
    end
    client = Twitter::Client.new
    begin
      client.update(message)
      return true
    rescue Exception => e
      self.errors.add(:oauth_token, "Unable to send to twitter: #{e.to_s}")
      return false
    end
  end
  
  def fb_authorize_url(callback_url = '')
    if self.oauth_authorize_url.blank?
      self.oauth_authorize_url = "https://graph.facebook.com/oauth/authorize?client_id=#{FACEBOOK_CLIENT_ID}&redirect_uri=#{callback_url}&scope=offline_access,publish_stream"
      self.save!
    end
    self.oauth_authorize_url
  end
  
  def fb_validate_oauth_token(oauth_verifier, callback_url = '')
   response = RestClient.get 'https://graph.facebook.com/oauth/access_token', :params => {
                  :type => 'client_cred',
                  :client_id => FACEBOOK_CLIENT_ID,
                  :redirect_uri => callback_url.html_safe,
                  :client_secret => FACEBOOK_CLIENT_SECRET,
                  :code => oauth_verifier.html_safe,
               }

    pair = response.body.split("&")[0].split("=")
    if (pair[0] == "access_token")
      self.oauth_token = pair[1]
      logger.info "self.oauth_token is :"+self.oauth_token
      response = RestClient.get 'https://graph.facebook.com/me', :params => { :access_token => self.oauth_token }
      self.stream_url = JSON.parse(response.body)["link"]
      self.active = true
    else 
      self.errors.add(:oauth_verifier, "Invalid token, unable to connect to facebook: #{pair[1]}")
      self.active = false
    end
    self.save!
  end
  
  def fb_post(message)
    RestClient.post 'https://graph.facebook.com/me/feed', { :access_token => self.oauth_token, :message => message }
  end
  
end
