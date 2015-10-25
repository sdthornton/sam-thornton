Rails.application.routes.draw do
  devise_for :admins, only: []

  namespace :v1, defaults: { format: :json } do

    resource :login, only: [:create], controller: :sessions

    get 'posts/faith' => 'posts#faith', as: 'posts_faith'
    get 'posts/tech' => 'posts#tech', as: 'posts_tech'
    resources :posts, except: [:index, :new, :edit]
    
  end
end
