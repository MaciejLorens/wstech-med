Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :metal_orders do
    resources :resources
    get :not_confirmed, on: :collection
    get :ordered, on: :collection
    get :delivered, on: :collection
    get :history, on: :member
  end

  resources :furniture_orders

  resources :wzs do
    get :download, on: :member
  end
end
