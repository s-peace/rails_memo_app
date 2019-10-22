Rails.application.routes.draw do
  root to: 'memos#index'
  resources :memos
end
