Rails.application.routes.draw do
  root  'memos#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  namespace :admin do
    resources :users
  end
  
  resources :memos do
    post :import, on: :collection
  end
end
