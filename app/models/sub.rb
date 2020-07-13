class Sub < ApplicationRecord
  validates :moderator_id, presence: true

  has_many :posts
  belongs_to :moderator,
    class_name: :User

end
