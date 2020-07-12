require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    before(:each) do
      @username = Time.now.to_s
      visit new_user_url
      fill_in 'username', with: @username
      fill_in 'password', with: 'password'
      click_on 'Create User'
    end

    scenario 'logs user in after signup' do
      expect(page).to have_text "Welcome #{@username}"
    end
  end
end

feature 'the login process' do
  scenario 'has a log in page' do
    visit new_session_url
    expect(page).to have_content 'Log In'
  end

  scenario 'gives login options when logged out' do
    visit new_session_url
    expect(page).to have_link('', href: new_session_url)
    expect(page).to have_link('', href: new_user_url)
  end


  feature 'logging in' do
    before(:each) do
      @username = Time.now.to_s
      FactoryBot.create(:user, username: @username, password: 'password')
      visit new_session_url
      fill_in 'username', with: @username
      fill_in 'password', with: 'password'
      click_on 'submit'
    end


  end

  feature 'logging out' do
    scenario 'has a logout button when logged in' do
      @username = Time.now.to_s
      FactoryBot.create(:user, username: @username, password: 'password')
      visit new_session_url
      fill_in 'username', with: @username
      fill_in 'password', with: 'password'
      click_on 'submit'
      expect(page).to have_text('Log Out')
      expect(page).to have_link('', href: session_url(User.last.id))
    end

    scenario 'doesn\'t have a logout button if not logged in' do
      visit new_session_url
      expect(page).not_to have_text('Log Out')
      expect(page).not_to have_link('', href: new_session_url(User.last.id))
    end
  end
end
