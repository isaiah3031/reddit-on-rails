class Post < ApplicationRecord
  validates :title, :author_id, presence: true

  has_many :posts_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, :through => :posts_subs
  
  has_many :comments
  belongs_to :author,
    class_name: :User

  def comments_by_parent_id
    all_comments = comments.includes(:author)
    
    sorted_hash = Hash.new { |h, k| h[k] = {} }
    all_comments.each do |comment|
      sorted_hash[comment.parent_comment_id] = [
        comment_hash(comment)
      ]
    end 
    sorted_hash
  end

  private

  def comment_hash(comment)
    { id: comment.id, parent_comment_id: comment.parent_comment_id,
      content: comment.content }
  end
end
