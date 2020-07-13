module SignInHelper
  def create_user(username)
    visit new_user_url
    fill_in 'username', with: username
    fill_in 'password', with: 'password'
    click_on 'Create User'
  end

  def login(username)
    visit new_session_url
    fill_in 'username', with: username
    fill_in 'password', with: 'password'
    click_on 'submit'
  end

  def logout
    click_on 'Log Out' if page.has_text?('Log Out')
  end
end

