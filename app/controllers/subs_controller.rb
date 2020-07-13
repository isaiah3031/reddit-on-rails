class SubsController < ApplicationController
  before_action :ensure_login, only: :create
  before_action :is_moderator?, only: %i[edit update]
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
      redirect_to sub_url(sub)
    else
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator?
    sub = Sub.find(params[:id])
    if logged_in? && sub.moderator_id == current_user.id
      true
    else
      # redirect_to subs_url
    end
  end
end
