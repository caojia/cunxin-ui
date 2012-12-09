class ChangeSupports < ActiveRecord::Migration
  def change
    add_column :supports, :name, :string
    add_column :supports, :weibo_url, :string
    add_column :supports, :blessing, :string
  end
end
