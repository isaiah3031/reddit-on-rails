class Post < ApplicationRecord
  validates :title, :author_id, :sub_id, presence: true

  has_many :posts_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, :through => :posts_subs
  
  belongs_to :author,
    class_name: :User
end

