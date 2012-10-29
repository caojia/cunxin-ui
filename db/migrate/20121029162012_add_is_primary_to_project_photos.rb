class AddIsPrimaryToProjectPhotos < ActiveRecord::Migration
  def change
    add_column :project_photos, :is_primary, :boolean, :default => false
    remove_column :projects, :thumbnail_large
    remove_column :projects, :thumbnail_small
  end
end
