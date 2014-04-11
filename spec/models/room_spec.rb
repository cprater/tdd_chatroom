require 'spec_helper'

describe Room do 	

	context 'when creating it should' do 
		it 'should exist' do 
			chatroom = Room.create(name: "roomie", created_by: 1)
			Room.exists?(chatroom).should be_true
		end

		it 'require name' do 
			chatroom = Room.create(name: "", created_by: 1)
			Room.exists?(chatroom).should be_false
		end

		it 'have unique name' do 
			chatroom = Room.create(name: "test", created_by: 1)
			chatroom2 = Room.create(name: "test", created_by: 1)
			Room.exists?(chatroom2).should be_false
		end
	end

	# context 'reguarding users' do 
	# 	let(:user) do 
	# 		User.create(username: "test", password: "123", password_confirmation: "123")
	# 	end

	# 	it 'should belong to a user' do 
	# 		chatroom = user.created_rooms.create(name: "rooms")
	# 		expect(chatroom.created_by.username).to eq"test"
	# 	end
	# end
end