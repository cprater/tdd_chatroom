class RoomController < ApplicationController
include RoomHelper

	def create
		@room = Room.create(name: params[:chatroom][:name], created_by: session[:current_user])
		add_to_members(@room)
		redirect_to room_path(@room.id)
	end

	def show
		@room = Room.find(params[:id])
		add_to_members(@room)
	end

	def leave
		@room = Room.find(params[:format])
		@room.leave(User.find(session[:current_user]))
		redirect_to user_path(User.find(session[:current_user]))
	end

	def add_message
		username = User.find(session[:current_user]).username
		@room = Room.find(params[:sending][:room_id])
		message = Message.new(message: params[:sending][:message], username: username)
		@room.messages << message
		@room.save
		redirect_to room_path(@room.id)
	end

end