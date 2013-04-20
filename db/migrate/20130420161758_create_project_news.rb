class CreateProjectNews < ActiveRecord::Migration
  def change
    create_table :project_news do |t|
      t.column :project_id, :integer, :null => false
      t.column :news, :string, :null => false
      t.column :published_at, :datetime, :default => nil
      t.column :position, :integer, :null => false, :default => 1

      t.timestamps
    end

    add_index :project_news, :published_at
    add_index :project_news, [:position, :published_at]
  end
end
