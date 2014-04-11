module SignupHelper
	def determine_signup_error(params)		
		if User.find_by_username(params[:username]) || params[:username].empty?
			return "Invalid Username"
		elsif params[:password].empty?
			return "Enter a Password"
		elsif params[:password] != params[:password_confirmation]
			return "Passwords don't match"
		end

	end

end