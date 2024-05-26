Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  root 'static_pages#top'

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :users, only: %i[new create]
  get 'profile', to: 'users#show'
  get 'profile/edit', to: 'users#edit', as: 'edit_profile'
  patch 'profile/update', to: 'users#update', as: 'update'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create' 
  delete 'logout', to: 'user_sessions#destroy'
  
  # 特定のボードのブックマーク一覧用のルートを追加
  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    resources :bookmarks, only: %i[create destroy], shallow: true
    get :bookmarks, on: :collection
  end

   # 管理者用の名前空間を追加
   namespace :admin do
    root "dashboards#index"
    resource :dashboard, only: %i[index]
    get 'login' => 'user_sessions#new', :as => :login
    post 'login' => "user_sessions#create"
    delete 'logout' => 'user_sessions#destroy', :as => :logout
    resources :boards, only: %i[index edit update show destroy]
    resources :users, only: %i[index edit update show destroy]
  end
end