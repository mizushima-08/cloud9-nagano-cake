Rails.application.routes.draw do
  devise_for :admin

  #Adminの管理
  namespace :admin do
    root 'homes#top'
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
  end


end
