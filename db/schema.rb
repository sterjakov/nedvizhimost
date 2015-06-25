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

ActiveRecord::Schema.define(:version => 20140819162341) do

  create_table "adverts", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "alt"
    t.integer  "parent_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "weight"
    t.string   "title"
    t.string   "meta_key"
    t.string   "meta_description"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.text     "description"
    t.string   "author"
    t.string   "email"
    t.integer  "post_id"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "author"
    t.string   "email"
    t.string   "phone"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "author"
    t.text     "description"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "houses", :force => true do |t|
    t.integer  "realty_type"
    t.integer  "apartment_type"
    t.integer  "apartment_age"
    t.string   "address"
    t.integer  "metro_id"
    t.integer  "house_type"
    t.integer  "floor_house"
    t.integer  "floor_apartments"
    t.float    "square_main"
    t.float    "square_live"
    t.float    "square_kitchen"
    t.integer  "balcon"
    t.integer  "loggia"
    t.integer  "room_type"
    t.integer  "windows"
    t.integer  "apartment_status"
    t.integer  "bathroom"
    t.text     "description"
    t.integer  "sell_type"
    t.string   "price"
    t.integer  "credit"
    t.integer  "residential_type"
    t.boolean  "deposit"
    t.integer  "period"
    t.integer  "comission"
    t.integer  "furniture_status"
    t.boolean  "furniture_floor"
    t.boolean  "furniture_kitchen"
    t.boolean  "refrigerator"
    t.boolean  "tv"
    t.boolean  "animal"
    t.boolean  "children"
    t.boolean  "washing_mashine"
    t.string   "fio"
    t.string   "phone"
    t.string   "email"
    t.integer  "status"
    t.string   "thumb"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "metro_time_on_foot"
    t.integer  "metro_time_transport"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "metros", :force => true do |t|
    t.string "name"
  end

  create_table "orders", :force => true do |t|
    t.string   "author"
    t.string   "phone"
    t.string   "email"
    t.text     "description"
    t.integer  "status"
    t.integer  "house_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "alt"
    t.text     "description"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "title"
  end

  create_table "photos", :force => true do |t|
    t.string   "image"
    t.integer  "house_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "alt"
    t.text     "description"
    t.string   "meta_key"
    t.string   "meta_description"
    t.integer  "category_id"
    t.string   "image"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.string   "image_alt"
    t.integer  "user_id"
  end

  create_table "settings", :force => true do |t|
    t.string   "title"
    t.string   "title_postfix"
    t.string   "email"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.integer  "similar_posts_count"
    t.text     "footer_description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "main_head"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
    t.string "alt"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "salt"
    t.integer  "role"
    t.string   "auth_token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
