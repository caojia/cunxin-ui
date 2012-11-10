class AddColumnAnonymousOnPayment < ActiveRecord::Migration
  def change
    add_column :payments, :anonymous, :boolean
  end
end
