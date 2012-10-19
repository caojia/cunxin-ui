class ChangeAccountTable < ActiveRecord::Migration
  def up
    add_column :accounts, :verify_type, :string, :size => 10
    add_column :accounts, :key, :string
    add_column :accounts, :email, :string
  end

  def down
    remove_column :accounts, :verify_type
    remove_column :accounts, :key
    remove_column :accounts, :email
  end
end
