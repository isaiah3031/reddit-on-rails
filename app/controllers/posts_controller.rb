class PostsController < ApplicationController
  before_action :logged_in?, except: %i[show]
  before_action :ensure_author, only: %i[edit update]
  def new
    render :new
  end

  def create
    post = Post.new(post_params)
    post.author_id = current_user.id
    post.sub_ids = params[:sub_id]
    if post.save
      redirect_to post_url(post)
    else
      debugger
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      redirect_to post_url(post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def ensure_author
    post = Post.find(params[:id])
    if !logged_in? || post.author_id != current_user.id
      redirect_to subs_url 
    end
  end
end
