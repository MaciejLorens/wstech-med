Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'search' => 'home#search'

  resources :orders do
    get :proposition, on: :collection
    get :ordered, on: :collection
    get :ready_to_delivery, on: :collection
    get :delivered, on: :collection
    get :deleted, on: :collection
    get :download, on: :collection
    get :history, on: :member
    put :release, on: :member
  end

end
