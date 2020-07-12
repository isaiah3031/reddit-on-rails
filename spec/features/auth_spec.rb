require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    before(:each) do
      FactoryBot.create(:user, username: 'testuser', password: 'password')
      visit new_user_url
      fill_in 'username', with: 'testuser'
      fill_in 'password', with: 'password'
      click_on 'Create User'
    end

    scenario 'redirects to Users show page after signup' do
      expect(page).to have_content 'Welcome testuser'
    end
  end
end