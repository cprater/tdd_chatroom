class Room < ActiveRecord::Base
	validates :name, presence: :true, uniqueness: :true
	belongs_to :user, foreign_key: "created_by"
end
