class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    
    if user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    else
      login(user)
      redirect_to user_url(user)
    end
  end
  

  def destroy
    @user = User.find(params[:id])
    if @user
      logout(@user)
      redirect_to subs_url
    end
  end

  private
end
