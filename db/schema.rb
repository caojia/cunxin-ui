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

ActiveRecord::Schema.define(:version => 20120904151021) do

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

  create_table "user_projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "followed_at"
    t.integer  "is_deleted"
    t.datetime "deleted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_projects", ["project_id"], :name => "index_user_projects_on_project_id"
  add_index "user_projects", ["user_id", "project_id"], :name => "index_user_projects_on_user_id_and_project_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "login"
    t.string   "display_name"
    t.string   "password"
    t.string   "thumbnail"
    t.text     "address"
    t.string   "zipcode"
    t.string   "mobile"
    t.string   "real_name"
    t.boolean  "sina_connected"
    t.datetime "sina_connected_at"
    t.string   "sina_token"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["sina_token"], :name => "index_users_on_sina_token"

end
