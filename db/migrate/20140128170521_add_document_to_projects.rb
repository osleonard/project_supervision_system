class AddDocumentToProjects < ActiveRecord::Migration
  def self.up
    add_attachment :projects, :document
  end

  def self.down
    remove_attachment :projects, :document
  end
end
