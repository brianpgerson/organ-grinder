PostsApp::Application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :posts, except: [:destroy] do
    resources :tags, only: [:create, :destroy]
  end
end
