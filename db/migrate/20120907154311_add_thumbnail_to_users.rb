class AddThumbnailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :thumbnail, :string
    add_column :users, :thumbnail_updated_at, :datetime
  end
end
