Rails.application.routes.draw do
  # これなんやっけ？
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/create'
  
  # トップページ
  root to: 'tasks#index'
  
  # ログイン処理用
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # ユーザ作成用 /users/signup でアクセスできるようにする。resources に追加してnewでも可。
  get 'signup', to: 'users#new'
  
  resources :users, only: [:create]
  resources :tasks
end
