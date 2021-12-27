Rails.application.routes.draw do
  # viewフォルダ"devise"の名前を変更したため、それを読み取るため
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  devise_for :admin

  #adminの管理
  namespace :admin do
    root 'homes#top'
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
    resources :customers, except: [:new, :create, :destroy]
  end

  #publicの管理
  scope module: :public do
    root 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    # customersコントローラー withdrawalアクションがまだ
    get '/customer/withdrawal' => 'customers#withdrawal', as: 'withdrawal_customer'
    resource :customer, only: [:show, :edit, :update]
    resources :addresses, except: [:show, :new ]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items' => 'cart_items#destroy_all'
    resources :orders, expect: [:create, :destroy, :edit]
    
  end

end
