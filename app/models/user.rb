class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  validates :username, :password_digest, :session_token, :presence => true
  validates :username, :session_token, :uniqueness => true
  validates :password, :length => { :minimum => 6 }, on: :create
  validates :password, :presence => true, on: :create

  before_validation :generate_session_token

  has_many(:goals)

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if user && user.is_password?(password)
  end


end
