class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end

  def login(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def logout(user)
    user.reset_session_token
    session[:session_token] = ''
  end

  def ensure_login
    unless logged_in?
      flash[:errors] = 'Must log in.'
      redirect_to new_session_url
    end
  end
end
