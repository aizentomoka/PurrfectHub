Rails.application.routes.draw do
  
# 顧客用
# URL /customers/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  
  
  
  
  
  namespace :admin do
    get 'rescued_cats/index'
    get 'rescued_cats/show'
  end
  namespace :admin do
    get 'diaries/index'
    get 'diaries/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'rescued_cats/new'
    get 'rescued_cats/index'
    get 'rescued_cats/show'
    get 'rescued_cats/edit'
  end
  namespace :public do
    get 'diaries/new'
    get 'diaries/index'
    get 'diaries/show'
    get 'diaries/edit'
  end
  namespace :public do
    get 'cats/new'
    get 'cats/index'
    get 'cats/show'
    get 'cats/edit'
  end
  get 'homes/top'
  get 'homes/about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
