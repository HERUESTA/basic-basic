Rails.application.routes.draw do
  root 'static_pages#top'

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
end