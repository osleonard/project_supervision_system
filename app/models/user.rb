class User < ActiveRecord::Base
    validates :name, presence: true, length: { maximum: 50 }
    VALID_MATRIC_REGEX = /(?<School>\w{3})\/(?<year>\d{2})\/(?<number>\d+)/i
    validates :matric_no, presence: true, format:{with: VALID_MATRIC_REGEX}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format:{with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
