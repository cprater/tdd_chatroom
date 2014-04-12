require 'spec_helper'

describe RoomController do 

	before(:each) do
		visit root_path
		within('#new_user') do 
			fill_in 'user[username]', :with => 'test'
			fill_in 'user[password]', :with => '123'
			fill_in 'user[password_confirmation]', :with => '123'
			click_button 'Create User'
		end		
	end

	context 'on the user profile page' do
		it 'should have create chatroom button' do 
			visit user_path(1)
			expect(page).to have_button('Create Chatroom')
		end
	end

	context 'when creating a chatroom through the form' do 
		it 'should exists' do 
			visit user_path(1)
			within('#new_room') do 
				fill_in 'chatroom[name]', :with => 'testroom'
				click_button 'Create Chatroom'
			end
			room = Room.find_by_name('testroom')
			Room.exists?(room).should be_true
		end
	end

	
end