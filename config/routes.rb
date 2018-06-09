Rails.application.routes.draw do
 root 'store#index', as: 'store_index'
 
  devise_for :users
 resources :products

 resources :items
 resources :carts
 resources :orders
end
