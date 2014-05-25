class Project < ActiveRecord::Base
  belongs_to :student
  has_attached_file :document
end
