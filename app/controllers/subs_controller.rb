class SubsController < ApplicationController
  before_action :ensure_login, only: :create
  def index
    render :index
  end

  def new
    render :new
  end

  def create
    sub = Sub.new(sub_params)
    sub.moderator_id = current_user.id
    if sub.save
      # redirect_to sub_url(sub)
    else
      # render :new
    end
  end

  def show
    render :show
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
