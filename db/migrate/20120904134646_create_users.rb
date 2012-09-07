class CreateUsers < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :address
      t.string :zipcode
      t.string :mobile
      t.string :real_name

      t.timestamps
    end

  end
end
