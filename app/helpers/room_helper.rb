module RoomHelper
	def add_to_members(room)
		user = User.find(session[:current_user])
		room.members << user.username unless room.members.include?(user.username)
		room.save
	end
end