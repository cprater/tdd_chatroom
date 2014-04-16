require 'spec_helper'

describe UserController do 

	context 'When signing up' do 
		it 'should display login form on landing page' do 
			visit root_path
			expect(page).to have_content('Welcome')
		end

		it 'should redirect to user page when signing up' do 
			visit root_path
			within('#new_user') do 
				fill_in 'user[username]', :with => 'test'
				fill_in 'user[password]', :with => '123'
				fill_in 'user[password_confirmation]', :with => '123'
				click_button 'Create User'
			end
			expect(page).to have_content('Welcome test')
		end

	context 'render correct error message when ' do 

		it 'no username entered' do 
			visit root_path
			within('#new_user') do 
				
				fill_in 'user[password]', :with => '123'
				fill_in 'user[password_confirmation]', :with => '123'
				click_button 'Create User'
			end
			expect(page).to have_content('Invalid Username')
		end

		it 'no password entered' do 
			visit root_path
			within('#new_user') do 
				fill_in 'user[username]', :with => 'test'
				
				click_button 'Create User'
			end
			expect(page).to have_content('Enter a Password')
		end

		it 'passwords don\'t match' do 
			visit root_path
			within('#new_user') do 
				fill_in 'user[username]', :with => 'test'
				fill_in 'user[password]', :with => '222'
				fill_in 'user[password_confirmation]', :with => '123'
				click_button 'Create User'
			end
			expect(page).to have_content('Passwords don\'t match')
		end
	end

	context 'on the profile page' do 
		before(:each) do 
			@user = User.create(username: "test", password: "123", password_confirmation: "123")
			@room = Room.create(name: "roomie", created_by: 1)
			visit user_login_path(user_id: 1)
			visit user_path(1)
		end

		it 'should display a links to available rooms' do 
			expect(page).to have_link 'roomie'
		end

		it 'room links should direct you to the room' do 
			click_link 'roomie'
			expect(page).to have_content 'roomie created by: test'
		end

		it 'room links should add user to the members list' do 
			click_link 'roomie'
			@room.members.include? 'test'
		end
	end
end

end