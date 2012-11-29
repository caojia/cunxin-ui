class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.integer :photo_id
      t.integer :position

      t.timestamps
    end
  end
end
