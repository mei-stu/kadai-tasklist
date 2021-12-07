Rails.application.routes.draw do
  get 'users/create'
  root to: 'tasks#index'
  
  # ユーザ作成用 /users/signup でアクセスできるようにする。resources に追加してnewでも可。
  get 'signup', to: 'users#new'
  
  resources :users, only: [:create]
  resources :tasks
end
