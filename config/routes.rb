Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :contacts

  # Defines the root path route ("/")
  root "contacts#index"
end
