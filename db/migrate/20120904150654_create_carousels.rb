class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.integer :project_id
      t.integer :position

      t.timestamps
    end
  end
end
