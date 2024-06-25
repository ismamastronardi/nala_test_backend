Rails.application.routes.draw do
  resources :employees do
    resources :absence_requests
  end

  resources :absence_requests, only: [:index, :show, :create, :update, :destroy]
end