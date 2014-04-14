class RoomController < ApplicationController


	def create
		@room = Room.create(name: params[:chatroom][:name], created_by: session[:current_user])
		redirect_to room_path(@room.id)
	end

	def show
		@room = Room.find(params[:id])
		@room.join(User.find(session[:current_user]))
	end

	def add_message
		username = User.find(session[:current_user]).username
		@room = Room.find(params[:sending][:room_id])
		@room.messages[username] = params[:sending][:message]
		@room.save
		redirect_to room_path(@room.id)
	end

end