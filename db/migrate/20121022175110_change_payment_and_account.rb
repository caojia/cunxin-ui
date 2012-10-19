class ChangePaymentAndAccount < ActiveRecord::Migration
  def up
    remove_column :payments, :payment_method
    change_column :accounts, :payment_method, :string, :size => 20
  end

  def down
    change_column :accounts, :payment_method, :string
    add_column :payments, :payment_method, :integer
  end
end
