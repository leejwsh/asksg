Asksg::Application.routes.draw do
  get 'tags/:tag', to: 'static_pages#home', as: :tag

  resources :users
  resources :sessions,  only: [:new, :create, :destroy]
  resources :answers,  only: [:create, :destroy]
  resources :questions

  root to: 'static_pages#home'

  match '/about',  to: 'static_pages#about'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/ask', to: 'questions#new'
end