class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      login(user_params[:username], user_params[:password])
      redirect_to user_url(user)
    else
      flash.now[:errors] = 'Invalid Params'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    
    params.require(:user).permit(:username, :password)
  end
end
