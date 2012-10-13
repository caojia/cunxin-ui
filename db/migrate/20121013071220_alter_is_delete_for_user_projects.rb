class AlterIsDeleteForUserProjects < ActiveRecord::Migration
  def up
    change_column :user_projects, :is_deleted, :boolean, :default => false
  end

  def down
    change_column :user_projects, :is_deleted, :integer, :default => 0
  end
end
