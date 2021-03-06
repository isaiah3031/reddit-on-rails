class Comment < ApplicationRecord
  validates :content, :author_id, :post_id, presence: true
  belongs_to :parent_comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    optional: true

  belongs_to :child_comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    optional: true

  belongs_to :post
  belongs_to :author,
    class_name: :User

  def latest_child
    comments = Comment.where(post_id: self.post_id)
    parent = self
    loop do
      child = comments.find_by(parent_comment_id: parent.id)
      break if child.nil?

      parent = child
    end
    parent
  end
end
