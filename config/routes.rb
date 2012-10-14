CunxinUi::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  get "users/sign_in", :to => "home#index"
  devise_for :users, :only => [:sessions, :passwords, :confirmations]

  # users
  get "signup", :to => "users#new", :as => :signup
  resources :users, :only => [:index, :create, :show]

  get "sina/connect", :to => "sina#connect", :as => :sina_connect
  get "sina/:action", :controller => "sina", :as => :sina

  # project
  resources :projects, :only => [:show]
  post "projects/follow/:id", :to => "projects#follow", :as => :follow

  # profile
  get "profile", :to => "profile#index", :as => :profile
  put "profile", :to => "profile#update", :as => :update_profile
  put "profile/:action", :controller => "profile", :as => :update_user_fields
  get "profile/projects", :to => "profile#projects", :as => :projects_profile

  # charity
  resources :charities, :only => [:show]

  # contributer
  resources :contributors, :only => [:show]

  # payment
  get "payment/donate", :to => "payment#donate"
  get "payment/success", :to => "payment#success"
  post "payment/pay", :to => "payment#pay"

end
