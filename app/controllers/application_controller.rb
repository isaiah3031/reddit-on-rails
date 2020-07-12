class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login(username, password)
    user = User.find_by_credentials(username, password)

    if user
      user.reset_session_token
      session[:session_token] = user.session_token
      user
    end
  end

  def logout(user)
    user.reset_session_token
    session[:session_token] = ''
  end
end
