require 'securerandom'

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_commit :ensure_session_token

  has_many :comments,
    foreign_key: :author_id
    
  has_many :posts,
    foreign_key: :author_id
    
  has_many :subs,
    class_name: :Sub,
    foreign_key: :moderator_id
    
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save
  end

  def self.generate_session_token
    SecureRandom.base64
  end 
 
  def password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.password?(password) ? (user) : (nil)
  end

  attr_reader :password

  def ensure_session_token
    self.session_token ||= User.generate_session_token
    self.save
  end
end
