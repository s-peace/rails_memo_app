Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get 'sessions/new'
  namespace :admin do
    resources :users
  end

  root  'memos#index'
  resources :memos
end
