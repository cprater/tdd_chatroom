class Room < ActiveRecord::Base
	serialize :members, Array
	serialize :messages, Hash
	validates :name, presence: :true, uniqueness: :true
	belongs_to :user, foreign_key: "created_by"
	

	def join(user)
		self.members << user.username
		self.save
	end

	def leave(user)
		self.members.delete(user.username)
		self.save
	end

	def username
		User.find(self.created_by).username
	end
end
