class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :payment_method
      t.string :target_account
      t.integer :amount
      t.string :currency_type, :size => 50
      t.string :order_id
      t.string :status, :size => 20

      t.timestamps
    end
  end
end
