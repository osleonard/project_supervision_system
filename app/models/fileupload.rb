class Fileupload < ActiveRecord::Base
  has_attached_file :document_avatar, :default_url => "/public/uploads/missing.doc"
end
