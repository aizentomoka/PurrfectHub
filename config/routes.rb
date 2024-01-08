Rails.application.routes.draw do
    
  root to: "homes#top"
  get "home/about"=>"homes#about"
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
    
    namespace :admin do
      resources :users, only: [:index, :show, :edit, :update]
      resources :diaries, only: [:index, :show]
      resources :rescued_cats, only: [:index, :show]
     
    end
    
   
   
    
    # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
    
     scope module: :public do
     
      get 'users/mypage' => 'users#show', as: 'mypage'
      get 'users/confirm_withdraw' => 'users#confirm_withdraw'
      patch 'users/withdraw' => 'users#withdraw'
      resources :users, only: [:index, :edit, :update]
      resources :cats, only: [:new, :create, :index, :update, :show, :edit] 
      resources :diaries
      resources :rescued_cats
    
      
    end
    
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
