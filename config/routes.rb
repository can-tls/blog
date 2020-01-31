Rails.application.routes.draw do
  root 'static_pages#home'
  post '/signup',  to: 'users#create'
  get  '/signup',  to: 'users#new'
  get 'login/new'
  get 'user/new'
  get '/show',     to: 'users#show'
  get '/show',     to: 'login#show'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'login#new'
  post '/login', to: 'login#create'
  resources :users
end
