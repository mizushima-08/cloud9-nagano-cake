Rails.application.routes.draw do
  # viewフォルダ"devise"の名前を変更したため、それを読み取るため
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }

  #adminの管理
  namespace :admin do
    root 'homes#top'
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
  end

  #publicの管理
  scope module: :public do
    root 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    # customersコントローラー
    # withdrawalアクションがまだ
    get '/customers/withdrawal' => 'customers#withdrawal'
    resources :customers, only: [:show, :edit, :update]
  end

end
