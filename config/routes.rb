Rails.application.routes.draw do
# def hi
#   def '/show'
#     User/idd
#     def idd
#         User.find(params[:id])
#       def user_params
#         params.require(:user).permit(:name, :email, :password) #confirmation entfernt
#       end
#     end
#   end
#  def
  root 'static_pages#home'
  post '/signup',  to: 'users#create'
  get  '/signup',  to: 'users#new'
  get 'login/new'
  get 'user/new'
  get '/show',     to: 'users#show'
  get '/show',     to: 'login#show'
  get '/all',      to: 'users#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'login#new'
  post '/login', to: 'login#create'
  delete '/logout', to: 'login#destroy'
  resources :users
end
