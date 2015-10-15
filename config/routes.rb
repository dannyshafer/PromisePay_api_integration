Rails.application.routes.draw do
  resources :users
  resources :cards
  resources :transactions
end
