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

	context 'reguarding users' do 
		before(:each) do 
			@user = User.create(username: "test", password: "123", password_confirmation: "123")
			@chatroom = Room.new(name: "testroom")
			@user.created_rooms << @chatroom
		end

		it 'should belong to a user' do			
			expect(@chatroom.created_by).to eq 1
		end

		it 'should exsist in its creators created_rooms' do
			expect(@user.created_rooms.count).to eq 1
		end

		it 'should be able to join a room' do 
			@chatroom.join(@user)
			expect(@chatroom.members.count).to eq 1
		end

		it 'should be able to leave a room' do
			@chatroom.leave(@user)
			expect(@chatroom.members.count).to eq 0
		end
	end
end