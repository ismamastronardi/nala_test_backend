Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :employees do
    resources :absence_requests
  end

  resources :absence_requests, only: [:index, :show, :create, :update, :destroy]
end