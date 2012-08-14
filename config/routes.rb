Tai::Application.routes.draw do
  
  resource :user, :only => [:new] 
  match '/interstitial' => "users#interstitial", :as => :users_interstitial
  match '/auth/:network/callback', :to => 'users#new'

  match '/make_a_choice' => "main#choose", :as => :network_choice
  
  resource :message
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

end
