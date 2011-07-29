Tai::Application.routes.draw do
  
  resource :twitter_account, :only => [:new] 
  match '/callback/twitter/' => "twitter_accounts#callback", :as => :twitter_callback
  
  resources :tweets, :only => [:new, :create, :show] 
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

end
