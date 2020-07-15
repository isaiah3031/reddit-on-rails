class Comment < ApplicationRecord
  validates :content, :author_id, :post_id, presence: true
  belongs_to :parent_comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    optional: true

  belongs_to :post
  belongs_to :author,
    class_name: :User
end
