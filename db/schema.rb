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

ActiveRecord::Schema.define(version: 20170430141150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "original_name"
    t.string   "new_name"
    t.integer  "size"
    t.string   "attachment_type"
    t.string   "url"
    t.integer  "post_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "img_url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "subject"
    t.integer  "fee"
    t.string   "link"
    t.string   "video_id"
    t.integer  "seq"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "teacher_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.text     "title"
    t.text     "choices",       default: [],              array: true
    t.integer  "anwser"
    t.text     "guides",        default: [],              array: true
    t.string   "video_url"
    t.text     "exercise_tags", default: [],              array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "difficulty",    default: [],              array: true
    t.text     "book",          default: [],              array: true
    t.text     "subject",       default: [],              array: true
  end

  create_table "flows", force: :cascade do |t|
    t.integer  "vip_id"
    t.string   "title"
    t.text     "body"
    t.string   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vip_id"], name: "index_flows_on_vip_id", using: :btree
  end

  create_table "meeting_blocks", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "link"
    t.integer  "category"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "tags"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "top",        default: 0
    t.text     "summary"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "vip_id"
    t.string   "q"
    t.text     "a"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vip_id"], name: "index_questions_on_vip_id", using: :btree
  end

  create_table "slides", force: :cascade do |t|
    t.string   "img_url"
    t.string   "link"
    t.string   "bg_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
    t.string   "long_name"
  end

  create_table "vips", force: :cascade do |t|
    t.string   "f1"
    t.string   "f2"
    t.string   "f3"
    t.string   "f4"
    t.string   "f5"
    t.string   "f6"
    t.string   "f7"
    t.string   "f8"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
