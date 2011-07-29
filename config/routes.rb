Tai::Application.routes.draw do
  
  resource :account, :only => [:new] 
  match '/callback/twitter/' => "accounts#twitter_callback", :as => :twitter_callback
  match '/callback/facebook/' => "accounts#facebook_callback", :as => :facebook_callback
  
  resources :tweets, :only => [:new, :create, :show] 
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

end
