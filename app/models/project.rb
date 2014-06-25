class Project < ActiveRecord::Base
  belongs_to :student
  has_attached_file :document
  do_not_validate_attachment_file_type :document
end
