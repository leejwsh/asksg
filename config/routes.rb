Asksg::Application.routes.draw do

  root to: 'static_pages#home'

  match '/about',  to: 'static_pages#about'
  match '/signup',  to: 'users#new'
end
