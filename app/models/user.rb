class User < ActiveRecord::Base
  before_save { self.matric_no = matric_no.downcase }
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_MATRIC_REGEX = /\w{3}\/\d{2}\/\d+/i
  validates :matric_no, presence: true, format:{with: VALID_MATRIC_REGEX}, uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password, if: ->(user) { user.password.present? }
end
