class Post < ApplicationRecord
  validates :title, :author_id, presence: true

  has_many :posts_subs
  has_many :subs, :through => :posts_subs
  
  belongs_to :author,
    class_name: :User
end

