Tai::Application.routes.draw do
    
  resource :twitter_account
  match '/callback/twitter/' => "twitter_accounts#callback", :as => :twitter_callback
  

end
