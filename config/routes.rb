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
    resources :requests
    resources :fulfillments
    resources :messages
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



