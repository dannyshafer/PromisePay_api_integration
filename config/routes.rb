Rails.application.routes.draw do
  resources :transactions
  resources :users
  resources :cards
end
