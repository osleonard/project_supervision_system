class Fileupload < ActiveRecord::Base
attr_accessible :document_avatar
has_attached_file :document_avatar :default_url => "/files/:style/missing.doc"
end
