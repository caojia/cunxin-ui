class CreateProjectPhotos < ActiveRecord::Migration
  def change
    create_table :project_photos do |t|
      t.integer :project_id
      t.integer :photo_id
      t.integer :position

      t.timestamps
    end
    add_index :project_photos, :project_id
    add_index :project_photos, :photo_id
  end
end
