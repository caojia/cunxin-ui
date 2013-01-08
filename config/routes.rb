CunxinUi::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  get "users/sign_in", :to => "home#index"
  devise_for :users, :only => [:sessions, :passwords, :confirmations]

  # users
  get "signup", :to => "users#new", :as => :signup
  post "users/bind", :to => "users#bind_account", :as => :bind_user
  post "users/resend_confirmation", :to => "users#resend_confirmation", :as => :resend_confirmation
  resources :users, :only => [:index, :create, :show]

  get "sina/connect", :to => "sina#connect", :as => :sina_connect
  get "sina/disconnect", :to => "sina#disconnect", :as => :sina_disconnect
  get "sina/:action", :controller => "sina", :as => :sina

  # project
  resources :projects, :only => [:show]
  post "projects/follow/:id", :to => "projects#follow", :as => :follow
  post "projects/unfollow/:id", :to => "projects#unfollow", :as => :unfollow
  get "projets/check_following/:id", :to => "projects#check_following", :as => :check_following

  # profile
  get "profile", :to => "profile#index", :as => :profile
  put "profile", :to => "profile#update", :as => :update_profile
  put "profile/:action", :controller => "profile", :as => :update_user_fields
  get "profile/projects", :to => "profile#projects", :as => :projects_profile
  get "profile/donations", :to => "profile#donations", :as => :donations_profile
  get "profile/rewards", :to => "profile#rewards", :as => :rewards_profile

  # charity
  resources :charities, :only => [:show]

  # contributer
  resources :contributors, :only => [:show]

  # donation
  get "donation/donate", :to => "donation#donate", :as => :donate
  get "donation/success", :to => "donation#success"
  get "donation/fail", :to => "donation#fail"
  post "donation/pay", :to => "donation#pay"
  get "donation/notify/:payment_type", :to => "donation#notify"
  post "donation/notify/:payment_type", :to => "donation#notify"

  get "terms", :to => "static#terms", :as => :terms
  get "about", :to => "static#about", :as => :about
  get "faq", :to => "static#faq", :as => :faq
  get "contact", :to => "static#contact", :as => :contact

  # support
  get "supports", :to => "supports#index", :as => :supports

  authenticated :user,  lambda {|u| u.roles_name.include? "admin"} do
    namespace :admin do 
      resources :items
      get "/", :to => "items#index"
    end
  end

end
