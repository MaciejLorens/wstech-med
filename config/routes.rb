Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'search' => 'home#search'

  resources :orders do
    get :ordered, on: :collection
    get :assembled, on: :collection
    get :ready_to_delivery, on: :collection
    get :delivered, on: :collection
    get :deleted, on: :collection
    get :download, on: :collection
    get :history, on: :member
    get :pdf, on: :member
    get :multi_pdf, on: :collection
    put :queue, on: :member
    put :suspend, on: :member
    put :restore, on: :member
    put :release, on: :member
  end

  resources :purchasers, only: [:destroy]

end
