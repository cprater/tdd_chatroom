class RoomController < ApplicationController


	def create
		@room = Room.create(name: params[:chatroom][:name], created_by: session[:current_user])
		redirect_to room_path(@room.id)
	end

	def show
		@room = Room.find(params[:id])
	end
end