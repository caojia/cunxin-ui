class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :payment_method
      t.string :target_account
      t.integer :charity_id
      t.integer :project_id

      t.timestamps
    end
  end
end
