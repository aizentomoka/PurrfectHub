Rails.application.routes.draw do
    
  namespace :public do
    get 'chats/show'
  end
  root to: "homes#top"
  get "home/about"=>"homes#about"
  
   #ゲストユーザー用
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end   
 
 
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
    
    namespace :admin do
      
      resources :users, only: [:index, :show, :edit, :update]
      
      resources :diaries, only: [:index, :destroy] do
        resources :diary_comments, only: [:index, :destroy]
      end
      
      resources :rescued_cats, only: [:index, :destroy] do
        resources :rescued_cat_comments, only: [:index, :destroy]
      end
     
    end
    
   
   
    
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
    
    scope module: :public do
     
      get 'users/confirm_withdraw' => 'users#confirm_withdraw'
      patch 'users/withdraw' => 'users#withdraw'
      
      resources :users, only: [:show, :edit, :update] do
         member do
           get :favorites 
           get :bookmarks
           get :diaries
           get :cats
           get :rescued_cats
           get :my_page
           get :follows, :followers
         end
           resource :relationships, only: [:create, :destroy]
      end
      
      resources :chats, only: [:show, :create, :destroy]
      resources :cats, only: [:new, :create, :update, :show, :edit] 
      resources :notifications, only: [:update]
      
      resources :diaries do
         resource :favorite, only: [:create, :destroy]
         resources :diary_comments, only: [:create, :destroy]
          collection do
            get 'search'
            get 'tag_search'
          end
      end
      
      resources :rescued_cats do
         resource :bookmark, only: [:create, :destroy]
         resources :rescued_cat_comments, only: [:create, :destroy]
         collection do
            get 'search'
            get 'label_search'
         end
      end
   
      
    end 
 
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
