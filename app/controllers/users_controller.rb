class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = 'Invalid Params'
      render :new
    end
  end

  def show
    render :show
  end

  private

  def user_params
    
    params.require(:user).permit(:username, :password)
  end
end
