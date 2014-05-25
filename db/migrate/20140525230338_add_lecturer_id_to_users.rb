class AddLecturerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lecturer_id, :integer
  end
end
