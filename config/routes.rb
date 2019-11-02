Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'search' => 'home#search'

  resources :orders do
    get :ordered, on: :collection
    get :production, on: :collection
    get :ready_to_delivery, on: :collection
    get :delivered, on: :collection
    get :deleted, on: :collection
    get :download, on: :collection
    get :history, on: :member
    get :pdf, on: :member
    put :suspend, on: :member
    put :finish, on: :member
    put :assembly, on: :member
    put :stages, on: :member
  end

  resources :purchasers

end
