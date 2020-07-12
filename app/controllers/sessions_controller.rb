class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = login(session_params[:username], session_params[:password])
    if user
      redirect_to user_url(user)
    else
      render :new
      flash.now[:errors] = "Invalid credentials"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      logout(@user)
    end
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
