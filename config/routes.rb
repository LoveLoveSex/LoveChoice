Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :hotels
  devise_for :users
  root 'home#index'

  get 'home/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
