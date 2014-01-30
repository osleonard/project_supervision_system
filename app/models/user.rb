class User < ActiveRecord::Base
  has_many :projects
  before_save { self.matric_no = matric_no.downcase }
  before_save { self.email = email.downcase }
  before_save  :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_MATRIC_REGEX = /\w{3}\/\d{2}\/\d+/i
  validates :matric_no, presence: true, format:{with: VALID_MATRIC_REGEX}, uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password, if: ->(user) { user.password.present? }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s) 
  end

  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64 unless remember_token 
  end

end
