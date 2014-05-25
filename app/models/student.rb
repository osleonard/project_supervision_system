class Student < User
  has_many :projects

  VALID_MATRIC_REGEX = /\w{3}\/\d{2}\/\d+/i

  belongs_to :lecturer
  has_many :projects
  validates :matric_no, presence: true, format:{with: VALID_MATRIC_REGEX}, uniqueness: {case_sensitive: false}

  before_save { self.matric_no = matric_no.downcase }
end
