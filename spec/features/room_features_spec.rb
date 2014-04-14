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

	context 'when displaying a chatroom' do 
		before(:each) do 
			@room = Room.create(name: 'roomie', created_by: 1)
		end

		it 'should display roomname' do 
			visit room_path(1)
			expect(page).to have_content 'roomie'
		end

		it 'should display creators name' do 
			visit room_path(1)
			expect(page).to have_content 'test'
		end

		it 'should display members' do 
			user = User.create(username: 'billy', password: '123', password_confirmation: '123')
			@room.join(user)
			visit room_path(1)
			expect(page).to have_content 'billy'
		end

		it 'should display chat messages' do 
			visit room_path(1)
			expect(page).to have_selector('.messages')
		end

		it 'should display a text field' do 
			visit room_path(1)
			expect(page).to have_field ('sending_message')
		end

		it 'should have a send message button' do 
			visit room_path(1)
			expect(page).to have_button ('Send')
		end
	end

	context 'chatting' do 
		before(:each) do 
			@room = Room.create(name: 'roomie', created_by: 1)
		end

		it 'should send messages to the screen' do 
			visit room_path(1)			
				fill_in 'sending_message', :with => 'This be a message'
				click_button 'Send'
				expect(page).to have_content 'This be a message'				
		end

		it 'should display all user\'s messages' do 
			visit room_path(1)
			fill_in 'sending_message', :with => 'Yo Zilla'
			click_button 'Send'
			fill_in 'sending_message', :with => 'Scrilla'
			click_button 'Send'

			expect(page).to have_content 'test: Yo Zilla' && 'test: Scrilla'
		end
	end
end