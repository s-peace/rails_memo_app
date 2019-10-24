Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  root  'memos#index'
  resources :memos
end
