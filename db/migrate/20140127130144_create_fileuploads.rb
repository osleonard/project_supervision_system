class CreateFileuploads < ActiveRecord::Migration
  def change
    create_table :fileuploads do |t|

      t.timestamps
    end
  end

  def self.up
    add_attachment :users, :document_avatar
  end

  def self.down
    remove_attachment :users, :document_avatar
  end
end
