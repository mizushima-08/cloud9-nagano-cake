Rails.application.routes.draw do
  devise_for :admin

  #Adminの管理
  namespace :admin do
    root 'homes#top'
  end

 
end
