class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :canonical_name
      t.string :headline
      t.text :short_description
      t.text :description
      t.string :thumbnail_large
      t.string :thumbnail_small
      t.integer :charity_id
      t.string :location
      t.string :target
      t.decimal :target_amount
      t.datetime :start_date
      t.integer :comments_count, :default => 0
      t.integer :donators_count, :default => 0
      t.decimal :current_amount, :default => 0
      t.boolean :published, :default => false
      t.datetime :published_at

      t.timestamps
    end

    add_index :projects, :canonical_name
    add_index :projects, :published
  end
end
