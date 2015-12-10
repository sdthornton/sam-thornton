Rails.application.routes.draw do
  devise_for :admins, only: []

  namespace :v1, defaults: { format: :json } do

    resource :login, only: [:create], controller: :sessions

    get 'faith' => 'posts#faith', as: 'posts_faith'
    get 'tech' => 'posts#tech', as: 'posts_tech'
    resources :posts, except: [:index, :new, :show]
    get 'posts/:ref' => 'posts#show', as: 'show_post'
    post 'contact' => 'contact#send', as: 'contact'

  end
end
