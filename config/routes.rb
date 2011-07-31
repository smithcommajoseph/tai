Tai::Application.routes.draw do
  
  resource :account, :only => [:new] 
  match '/callback/twitter/' => "accounts#twitter_callback", :as => :twitter_callback
  match '/callback/facebook/' => "accounts#fb_callback", :as => :facebook_callback
  
  resources :messages, :only => [:new, :create, :show] 
  
  match '/main/make_a_choice' => "main#choose", :as => :network_choice
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

end
