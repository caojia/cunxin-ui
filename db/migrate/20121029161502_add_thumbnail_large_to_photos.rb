class AddThumbnailLargeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :thumbnail_large, :string, :default => :thumbnail_small
  end
end
