require 'spec_helper'

describe UserController do 

	context 'When signing up' do 
		it 'should display signup form on landing page' do 
			visit root_path
			expect(page).to have_selector('#new_user')
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

	context 'When logging in' do 
		let(:user) do 
			User.create(username: "test", password: "123", password_confirmation: "123")
		end

		it 'should display login form' do 
			visit root_path
			expect(page).to have_selector('#login')
		end

		it 'should log in user and direct to profile page' do 
			visit root_path
			within('#login') do 
				fill_in 'user[username]', :with => user.username
				fill_in 'user[password]', :with => user.password
				click_button 'Login'				
			end
			expect(page).to have_content 'Welcome test'
		end

		it 'should throw an error with invalid login info' do 
			visit root_path
			within('#login') do 
				fill_in 'user[username]', :with => "boobs"
				fill_in 'user[password]', :with => "sboob"
				click_button 'Login'				
			end
			expect(page).to have_content 'Invalid Information'
		end

		it 'should throw error when no info is entered' do 
			visit root_path
			within('#login') do 
				click_button 'Login'
			end
			expect(page).to have_content 'Invalid Information'
		end
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
			visit root_path
			within('#login') do 
				fill_in 'user[username]', :with => @user.username
				fill_in 'user[password]', :with => @user.password
				click_button 'Login'
			end
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