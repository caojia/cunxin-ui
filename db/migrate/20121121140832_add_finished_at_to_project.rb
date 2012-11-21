class AddFinishedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :finished_at, :datetime
  end
end
