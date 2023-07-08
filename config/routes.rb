require 'sidekiq/web'
Rails.application.routes.draw do
  # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => '/sidekiq'
  scope format: false do
    # your routes here
    resources :users
    resources :requests do
        collection do
          get :my_requests
          get :fulfilled_requests
          get :unfulfilled_requests
          get :archived_requests
          get '/request_owner', to: 'requests#request_owner'
          get '/fulfilled-requests:id', to: 'requests#volunteer'
        end
    end
    resources :fulfillments do
      collection do
        get :my_fulfillments
      end
    end
    resources :messages do
        collection do
          get '/conversation/:user_id', to: 'messages#conversation'
        end
    end
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'

    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }
    #password update and reset link routes
    devise_scope :user do
      put '/password/update', to: 'users/sessions#update_password'
      post '/users/password/reset', to: 'users/password_resets#create', as: :user_password_reset
    end

    namespace :users do
      resources :password_resets, only: [:new, :create, :edit, :update]
    end

  end
  
end



