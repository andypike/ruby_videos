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

ActiveRecord::Schema.define(version: 20150222213425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "presenters", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "twitter",    default: "", null: false
    t.string   "github",     default: "", null: false
    t.string   "website",    default: "", null: false
    t.string   "title",      default: "", null: false
    t.text     "bio",        default: "", null: false
    t.string   "photo",      default: "", null: false
    t.string   "slug"
  end

  add_index "presenters", ["slug"], name: "index_presenters_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "nickname",   default: "", null: false
    t.string   "name",       default: "", null: false
    t.string   "image_url",  default: "", null: false
    t.string   "provider",                null: false
    t.string   "uid",                     null: false
    t.integer  "role",       default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "title",        default: "", null: false
    t.text     "description",  default: "", null: false
    t.integer  "presenter_id"
    t.string   "url",          default: "", null: false
    t.text     "embed_code",   default: "", null: false
    t.integer  "status",       default: 0,  null: false
    t.string   "cover",        default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "slug"
  end

  add_index "videos", ["presenter_id"], name: "index_videos_on_presenter_id", using: :btree
  add_index "videos", ["slug"], name: "index_videos_on_slug", unique: true, using: :btree

  add_foreign_key "videos", "presenters"
end
