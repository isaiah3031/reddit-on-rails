class Sub < ApplicationRecord
  validates :moderator_id, presence: true
  has_many :posts_subs
  has_many :posts, :through => :posts_subs

  belongs_to :moderator,
    class_name: :User
end
