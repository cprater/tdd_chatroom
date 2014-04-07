require 'spec_helper'

describe UserController do
	
	it 'display login form'	do
		visit root_path
		
		expect(page).to have_content ('#new_user')
	end

	
end