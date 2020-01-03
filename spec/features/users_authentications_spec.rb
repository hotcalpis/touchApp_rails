require 'rails_helper'

RSpec.feature 'users_authentications', type: :feature do

  feature 'user registration' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    scenario 'invalid signup information' do
      visit new_user_registration_path
      before_count = User.count
      fill_in "Name",                  with: ''
      fill_in "Email",                 with: 'user@invalid'
      fill_in "Password",              with: 'foo'
      fill_in "Password confirmation", with: 'bar'
      click_on 'Sign up'
      expect(User.count).to eq(before_count)
    end

    scenario 'valid signup information' do
      visit new_user_registration_path
      before_count = User.count
      fill_in "Name",                  with: 'ExampleUser'
      fill_in "Email",                 with: 'user@example.com'
      fill_in "Password",              with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_on 'Sign up'
      expect(User.count).to eq(before_count + 1)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

  

  feature 'user login' do
  end

  feature 'user edit' do
  end

  feature 'user new_password_reset' do
  end
  
  feature 'user edit_password_reset' do
  end
end