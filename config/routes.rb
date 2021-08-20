Rails.application.routes.draw do
  #admin
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
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
      resource :customers, only: [:show, :edit, :update,] do
        collection do
          get 'quit'
          patch 'out'
        end
      end
      resources :cart_items, only: [:index, :update, :destroy, :create] do
        collection do
          delete 'all_destroy'
        end
      end
      resources :orders, only: [:new, :create, :index, :show] do
        collection do
          post 'confirm'
          get 'thanks'
        end
      end
      resources :shipping_addresser, only: [:index, :edit, :create, :update, :destroy]
    end
end



