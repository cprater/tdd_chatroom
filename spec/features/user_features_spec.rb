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

		it 'render correct error message when no username entered' do 
			visit root_path
			within('#new_user') do 
				
				fill_in 'user[password]', :with => '123'
				fill_in 'user[password_confirmation]', :with => '123'
				click_button 'Create User'
			end
			expect(page).to have_content('Invalid Username')
		end

		it 'render correct error message when no password entered' do 
			visit root_path
			within('#new_user') do 
				fill_in 'user[username]', :with => 'test'
				
				click_button 'Create User'
			end
			expect(page).to have_content('Enter a Password')
		end
	end

end