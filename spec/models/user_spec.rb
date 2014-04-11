require 'spec_helper'

describe User do
	I18n.enforce_available_locales = false
	
	it 'creates new user'	do
		user = User.create(username: "test", password: "123", password_confirmation: "123")		
		User.exists?(user).should be_true
	end

	context 'should not create user when' do 
		it 'no username is entered' do 
			user = User.create(username: "", password: "123", password_confirmation: "123")
			User.exists?(user).should be_false
		end

		it 'username is already taken' do 
			user1 = User.create(username: "test", password: "123", password_confirmation: "123")
			user2 = User.create(username: "test", password: "123", password_confirmation: "123")
			
			User.exists?(user2).should be_false
		end

		it 'no password is entered' do 
			user = User.create(username: "test", password: "", password_confirmation: "")
			User.exists?(user).should be_false
		end

		it 'the passwords do not match' do 
			user = User.create(username: "test", password: "123", password_confirmation: "234")
			User.exists?(user).should be_false
		end
	end
	
end