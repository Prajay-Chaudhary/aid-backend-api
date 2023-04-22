# Rails.application.routes.draw do
# #todo remove unnesessary formats
#     resources :requests
#     devise_for :users, path: '', path_names: {
#       sign_in: 'login',
#       sign_out: 'logout',
#       registration: 'signup'
#     },
#     controllers: {
#       sessions: 'users/sessions',
#       registrations: 'users/registrations'
#     }
  
# end

Rails.application.routes.draw do
#todo remove unnesessary formats
  scope format: false do
    # your routes here
    resources :messages do
      collection do
        get :my_messages
      end
    end
    resources :requests do
        collection do
          get :my_requests
        end
    end
    resources :fulfillments
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



