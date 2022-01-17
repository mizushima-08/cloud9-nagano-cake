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
    # url"/"を注文履歴に
    root 'orders#index'
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
    resources :customers, except: [:new, :create, :destroy]
    resources :orders, only: [:show, :index]
    get '/customer/:id/orders' => 'orders#index', as: "customer_data_orders" # 会員詳細 => 注文履歴の表示データを変える用
    patch "orders/order_status" => "orders#order_status_update"
    patch "orders/item_status" => "orders#item_status_update"
  end

  #publicの管理
  scope module: :public do
    root 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    # customersコントローラー withdrawalアクションがまだ
    get '/customer/withdrawal' => 'customers#withdrawal', as: 'withdrawal_customer'
    patch '/customer/switch' => 'customers#switch', as: 'withdrow_switch_customer'
    resource :customer, only: [:show, :edit, :update]
    resources :addresses, except: [:show, :new ]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items' => 'cart_items#destroy_all'
    resources :orders, except: [:update, :edit, :destroy]
    get '/order/thanks' => 'orders#thanks'
    post 'order/confirm' => 'orders#confirm'
  end

end
