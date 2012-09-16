class RenamePhotoColumn < ActiveRecord::Migration
  def up
    rename_column :photos, :thumbnail, :thumbnail_small
    rename_column :photos, :title, :name
  end

  def down
    rename_column :photos, :thumbnail_small, :thumbnail
    rename_column :photos, :name, :title
  end
end
