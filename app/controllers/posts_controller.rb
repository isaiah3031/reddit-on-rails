class PostsController < ApplicationController
  def new
    render :new
  end

  def create
    post = Post.new(post_params)
    post.author_id = current_user.id
    post.sub_id = params[:sub_id]
    
    if post.save
      # redirect_to post_url(post)
    else
      debugger
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
