Rails.application.routes.draw do
  resources :projects, only: [:index, :new, :create]
  get "/login", to: "sessions#new"
  resource :session
  resources :passwords, param: :token
  get "up" => "rails/health#show", as: :rails_health_check
  root "projects#index"
end
