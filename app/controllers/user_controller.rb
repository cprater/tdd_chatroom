class UserController < ApplicationController
include SignupHelper

	def index
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@rooms = Room.all
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:current_user] = @user.id
			redirect_to user_path(@user.id)
		else
			flash[:error] = determine_signup_error(user_params)
			render 'index'
		end
	end

	def login
		session[:current_user] = params[:user_id]
		render nothing: :true
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :password_digest)
	end

end