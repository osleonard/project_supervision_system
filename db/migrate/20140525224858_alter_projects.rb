class AlterProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :user_id, :student_id
  end
end
