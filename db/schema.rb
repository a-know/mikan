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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150520131158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mikanzs", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "name",                     null: false
    t.text     "content",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "completion",   default: 0
    t.string   "mikanz_image"
    t.integer  "start_year"
    t.integer  "start_month"
  end

  add_index "mikanzs", ["deleted_at"], name: "index_mikanzs_on_deleted_at", using: :btree
  add_index "mikanzs", ["owner_id"], name: "index_mikanzs_on_owner_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "nickname",   null: false
    t.string   "image_url",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

  create_table "waterings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "mikanz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "waterings", ["mikanz_id", "user_id"], name: "index_waterings_on_mikanz_id_and_user_id", unique: true, using: :btree
  add_index "waterings", ["mikanz_id"], name: "index_waterings_on_mikanz_id", using: :btree
  add_index "waterings", ["user_id", "mikanz_id"], name: "index_waterings_on_user_id_and_mikanz_id", unique: true, using: :btree
  add_index "waterings", ["user_id"], name: "index_waterings_on_user_id", using: :btree

  add_foreign_key "waterings", "mikanzs"
  add_foreign_key "waterings", "users"
end
