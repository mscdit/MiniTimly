Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'welcome#index'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  get '/users/:id/profile', to: 'users/profiles#index'
  get '/users/:id/profile/generateApiKey', to: 'users/profiles#generateApiKey'

  resources :items

  # nested route for API
  namespace :api do
    namespace :v1 do
      resources :items
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
