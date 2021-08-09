Rails.application.routes.draw do
  #admin
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  namespace :admin do
    #resources :homes, only: [:top]
    root 'homes#top', as: :root
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  	resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end
  #public
  devise_for :publics, controllers: {
    sessions: 'publics/sessions',
    passwords: 'publics/passwords',
    registrations: 'publics/registrations'
  }
    root to: 'public/homes#top'
    get 'about' => 'public/homes#about'
    scope module: :public do
    resources :items, only: [:index, :show]
    resource :customers, only: [:show, :edit, :update,]
    end
end


