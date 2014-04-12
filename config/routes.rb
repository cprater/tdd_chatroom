Chatroom::Application.routes.draw do

  root to: 'user#index'
  resources :user
  resources :room

end
