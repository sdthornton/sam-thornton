Rails.application.routes.draw do
  devise_for :admins, only: []

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resource :login, only: [:create], controller: :sessions
      resources :posts, except: [:new, :edit]
    end
  end
end
