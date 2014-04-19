Chatroom::Application.routes.draw do

  root to: 'user#index'
  resources :user
  resources :room
  
  post '/add_message', to: 'room#add_message'
  post '/user_login', to: 'user#login'
  post '/leave_room', to: 'room#leave'
  
end
