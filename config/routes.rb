CunxinUi::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :only => :sessions

  # users
  get "users/new", :to => "users#new", :as => :signup
  resources :users, :only => [:show, :index, :create]

  get "sina/:action", :controller => "sina", :as => :sina

end
