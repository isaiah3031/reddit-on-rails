require 'rails_helper'
require './test/test_helpers/user_auth.rb'

include SignInHelper
feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    before(:each) do
      @username = Time.now.to_s
      create_user(@username)
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
end

feature 'logging out' do
  scenario 'doesn\'t have a logout button if not logged in' do
    visit new_session_url
    logout
    expect(page).not_to have_text('Log Out')
    expect(page).not_to have_link('', href: new_session_url(User.last.id))
  end

  before(:each) do
    @username = Time.now.to_s
    create_user(@username)
  end

  scenario 'has a logout button when logged in' do
    visit new_session_url
    login(@username)
    expect(page).to have_text('Log Out')
    expect(page).to have_link('', href: session_url(User.last.id))
  end
end
