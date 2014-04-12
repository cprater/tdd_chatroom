class Room < ActiveRecord::Base
	attr_reader :members
	validates :name, presence: :true, uniqueness: :true
	belongs_to :user, foreign_key: "created_by"
	before_create :create_members
	

	def join(user)
		@members << user.username
	end

	def leave(user)
		@members.delete(user.username)
	end

	def username
		User.find(self.created_by).username
	end

# private
	def create_members
		@members = []
	end
end
