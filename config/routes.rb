Rails.application.routes.draw do
  resources :transactions
  resources :users do
    resources :cards
  end
end
