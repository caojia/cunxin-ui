class AddColumnToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :location, :string
    add_column :supports, :career, :string
  end
end
