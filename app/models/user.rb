class User < ActiveRecord::Base
	has_secure_password	
	validates :username, uniqueness: true, presence: true
	has_many :rooms, foreign_key: "created_rooms"
end
