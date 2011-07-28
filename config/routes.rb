Tai::Application.routes.draw do
  
  resource :twitter_account
  resource :tweet
  match '/callback/twitter/' => "twitter_accounts#callback", :as => :twitter_callback
  
  match '/slight/generator' => 'slight#generator', :as => :slight_generator
  match '/slight/success' => 'slight#success', :as => :slight_success
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

end
