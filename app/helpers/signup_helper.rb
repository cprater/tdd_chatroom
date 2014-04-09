module SignupHelper
	def determine_signup_error(params)
		# binding.pry
		if User.find_by_username(params[:username]) || params[:username].empty?
			return "Invalid Username"
		end

	end

end