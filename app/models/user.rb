class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save  :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password, if: ->(user) { user.password.present? }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def students
    # code here
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64 unless remember_token
  end

end
