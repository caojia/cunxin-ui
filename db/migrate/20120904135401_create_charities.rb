class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :canonical_name
      t.string :name
      t.string :thumbnail_large
      t.string :thumbnail_small
      t.text :description
      t.text :short_description
      t.decimal :total_amount
      t.string :link_url
      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end

    add_index :charities, :canonical_name
    add_index :charities, :published
  end
end
