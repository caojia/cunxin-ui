class CreateOauthUsers < ActiveRecord::Migration
  def change
    create_table :oauth_users do |t|
      t.integer :user_id
      t.string :oauth_uid
      t.string :oauth_token
      t.integer :oauth_token_expires_at
      t.string :type

      t.timestamps
    end

    add_index :oauth_users, [:user_id, :oauth_uid]
    add_index :oauth_users, [:oauth_uid, :type], :unique => true
  end
end
