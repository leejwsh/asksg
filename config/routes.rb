Asksg::Application.routes.draw do

  resources :users

  root to: 'static_pages#home'

  match '/about',  to: 'static_pages#about'
  match '/signup',  to: 'users#new'
end
