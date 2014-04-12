class User < ActiveRecord::Base
	has_secure_password	
	validates :username, uniqueness: true, presence: true
	has_many :rooms
	has_many :created_rooms, class_name: "Room", foreign_key: "created_by"
end
