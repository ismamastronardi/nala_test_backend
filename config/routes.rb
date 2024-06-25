Rails.application.routes.draw do
  resources :absence_requests
  resources :employees do
    resources :absence_requests
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
