Rails.application.routes.draw do
  root 'static_pages#top'

  resources :users, only: %i[new create]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  # 特定のボードのブックマーク一覧用のルートを追加
  resources :boards do
    resources :comments, only: %i[create], shallow: true
    resources :bookmarks, only: %i[create destroy], shallow: true
    get :bookmarks, on: :collection
  end
end