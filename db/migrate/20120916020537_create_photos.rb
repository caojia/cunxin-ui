class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.string :thumbnail
      t.string :link

      t.timestamps
    end
  end
end
