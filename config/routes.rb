CunxinUi::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users, :only => [:sessions, :passwords, :confirmations]

  # users
  get "users/new", :to => "users#new", :as => :signup
  resources :users, :only => [:index, :create, :show]

  get "sina/:action", :controller => "sina", :as => :sina

  # project
  resources :projects, :only => [:show]

end
