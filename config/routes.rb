Rails.application.routes.draw do
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
      registrations: 'users/registrations'
    }
  end
  
end



