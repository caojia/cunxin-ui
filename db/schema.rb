# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121015152817) do

  create_table "accounts", :force => true do |t|
    t.string   "payment_method"
    t.string   "target_account"
    t.integer  "charity_id"
    t.integer  "project_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "carousels", :force => true do |t|
    t.integer  "project_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "charities", :force => true do |t|
    t.string   "canonical_name"
    t.string   "name"
    t.string   "thumbnail_large"
    t.string   "thumbnail_small"
    t.text     "description"
    t.text     "short_description"
    t.decimal  "total_amount",      :precision => 10, :scale => 0
    t.string   "link_url"
    t.boolean  "published"
    t.datetime "published_at"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "charities", ["canonical_name"], :name => "index_charities_on_canonical_name"
  add_index "charities", ["published"], :name => "index_charities_on_published"

  create_table "contributors", :force => true do |t|
    t.string   "canonical_name"
    t.string   "name"
    t.string   "thumbnail_large"
    t.string   "thumbnail_small"
    t.text     "description"
    t.text     "short_description"
    t.string   "quoted_words"
    t.string   "signature"
    t.string   "type"
    t.boolean  "published"
    t.datetime "published_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "contributors", ["canonical_name"], :name => "index_contributors_on_canonical_name"
  add_index "contributors", ["published"], :name => "index_contributors_on_published"

  create_table "oauth_users", :force => true do |t|
    t.integer  "user_id"
    t.string   "oauth_uid"
    t.string   "oauth_token"
    t.integer  "oauth_token_expires_at"
    t.string   "type"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "oauth_users", ["oauth_uid", "type"], :name => "index_oauth_users_on_oauth_uid_and_type", :unique => true
  add_index "oauth_users", ["user_id", "oauth_uid"], :name => "index_oauth_users_on_user_id_and_oauth_uid"

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "payment_method"
    t.string   "target_account"
    t.integer  "amount"
    t.string   "currency_type"
    t.string   "order_id"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "thumbnail_small"
    t.string   "link"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.text     "address"
    t.string   "zipcode"
    t.string   "mobile"
    t.string   "real_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_photos", :force => true do |t|
    t.integer  "project_id"
    t.integer  "photo_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "project_photos", ["photo_id"], :name => "index_project_photos_on_photo_id"
  add_index "project_photos", ["project_id"], :name => "index_project_photos_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "canonical_name"
    t.string   "headline"
    t.text     "short_description"
    t.text     "description"
    t.string   "thumbnail_large"
    t.string   "thumbnail_small"
    t.integer  "charity_id"
    t.string   "location"
    t.string   "target"
    t.decimal  "target_amount",     :precision => 10, :scale => 0
    t.datetime "start_date"
    t.integer  "comments_count",                                   :default => 0
    t.integer  "donators_count",                                   :default => 0
    t.decimal  "current_amount",    :precision => 10, :scale => 0, :default => 0
    t.boolean  "published",                                        :default => false
    t.datetime "published_at"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  add_index "projects", ["canonical_name"], :name => "index_projects_on_canonical_name"
  add_index "projects", ["published"], :name => "index_projects_on_published"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "followed_at"
    t.boolean  "is_deleted",  :default => false
    t.datetime "deleted_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "user_projects", ["project_id"], :name => "index_user_projects_on_project_id"
  add_index "user_projects", ["user_id", "project_id"], :name => "index_user_projects_on_user_id_and_project_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "thumbnail"
    t.datetime "thumbnail_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
