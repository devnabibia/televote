Rails.application.routes.draw do
  resources :campaigns, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'campaigns#index'
end
