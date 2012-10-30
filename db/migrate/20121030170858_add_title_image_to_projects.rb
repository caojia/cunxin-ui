class AddTitleImageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :title_image, :string
  end
end
