class ChangePaymentTable < ActiveRecord::Migration
  def up
    change_column :payments, :amount, :decimal, :precision => 32, :scale => 4, :null => false
    remove_column :payments, :target_account
    add_column    :payments, :account_id, :integer, :null => false
  end

  def down
    remove_column :payments, :account_id
    add_column    :payments, :target_account, :integer
    change_column :payments, :amount, :integer
  end
end
