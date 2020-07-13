class Sub < ApplicationRecord
  validates :moderator_id, presence: true

  belongs_to :moderator,
    class_name: :User
end
