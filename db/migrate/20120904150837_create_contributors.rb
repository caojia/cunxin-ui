class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :canonical_name
      t.string :name
      t.string :thumbnail_large
      t.string :thumbnail_small
      t.text :description
      t.text :short_description
      t.string :quoted_words
      t.string :signature
      t.string :type

      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end

    add_index :contributors, :canonical_name
    add_index :contributors, :published
  end
end
