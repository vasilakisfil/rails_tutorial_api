Rails.application.routes.draw do
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  add_relationship_links = Proc.new do
    collection do
      get :index
      put :update
    end
    member do
      post :create
      get :show
      delete :destroy
    end
  end

  #api
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        namespace :links do
          resources :followers, only: [] do
            add_relationship_links.call
          end
          resources :following, only: [] do
            add_relationship_links.call
          end
        end
      end
      resources :microposts, only: [:index, :create, :show, :update, :destroy]
      resources :sessions, only: [:create]
    end
  end
end
