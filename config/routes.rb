Rails.application.routes.draw do
  #admin
  devise_for :admins, controllers: {
   sessions: "admins/sessions"
 }
  namespace :admins do
    resources :homes, only: [:top]
    resources :items, only: [:index, :new, :create, :show, :edit, :update,]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  	resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end
  #public
  devise_for :publics, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
    root to: 'public/homes#top'
    get 'about' => 'public/homes#about'
    resources :items, only: [:index, :show]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :customers, only: [:show, :edit, :update,]
  end
 
