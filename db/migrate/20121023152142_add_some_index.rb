class AddSomeIndex < ActiveRecord::Migration
  def up
    add_index :payments, :user_id
    add_index :payments, :project_id
    add_index :payments, :order_id, :unique => true
    add_index :payments, :account_id

    add_index :accounts, :charity_id
    add_index :accounts, :project_id
  end

  def down
    drop_index :accounts, :project_id
    drop_index :accounts, :charity_id

    drop_index :payments, :account_id
    drop_index :payments, :order_id
    drop_index :payments, :project_id
    drop_index :payments, :user_id
  end
end
