Rails.application.routes.draw do
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  root  'memos#index'
  
  namespace :admin do
    resources :users
  end
  
  resources :memos do
    post :import, on: :collection
  end
end
