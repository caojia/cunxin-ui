class AddSelectMethodToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :select_payment_method, :string
  end
end
