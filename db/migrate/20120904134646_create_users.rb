class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :login
      t.string :display_name
      t.string :password
      t.string :thumbnail
      t.text :address
      t.string :zipcode
      t.string :mobile
      t.string :real_name
      t.boolean :sina_connected
      t.datetime :sina_connected_at
      t.string :sina_token

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :login
    add_index :users, :sina_token

  end
end
