Chatroom::Application.routes.draw do

  root to: 'user#index'
  resources :user
  resources :room
  
  post '/add_message', to: 'room#add_message'
  get '/user_login', to: 'user#login'
  
end
