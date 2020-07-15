class Comment < ApplicationRecord
  validates :content, :author_id, :post_id, presence: true

  belongs_to :post
  belongs_to :author,
    class_name: :User
end
