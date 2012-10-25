class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :payment_method
      t.text :detail

      t.timestamps
    end
  end
end
