class CommentsController < ApplicationController
  def new
    @post_id = params[:post_id]
    render :new
  end

  def create
    comment = Comment.new(comment_params)
    comment.author_id = current_user.id

    if comment.save
      redirect_to post_url(comment.post)
    else
      flash.now[:error] = 'Must contain a comment.'
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @comment_chain = @comment.child_comment.includes(:author)
    
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

  def child_comments(comment)
    comment_chain = comment
    loop do
      comment.child_comment
    end
  end
end
