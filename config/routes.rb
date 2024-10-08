Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#index'

  resources :heroes do
    collection do
      get :statistics
      get :importer
      post :import
    end
  end
  
  resources :equipments do
    collection do
      get :importer
      post :import
    end
    member do
      post :duplicate
    end
  end
end
