class PostsSub < ApplicationRecord
  validates :post, presence: true
  validates :sub_id, presence: true, uniqueness: { scope: :post_id }

  belongs_to :post,
    foreign_key: :post_id
  belongs_to :sub,
    foreign_key: :sub_id
end
