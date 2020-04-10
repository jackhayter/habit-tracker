# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_07_233255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "date", null: false
    t.uuid "tracker_id", null: false
    t.uuid "grade_id", null: false
    t.index ["grade_id"], name: "index_entries_on_grade_id"
    t.index ["tracker_id", "date"], name: "index_entries_on_tracker_id_and_date", unique: true
    t.index ["tracker_id"], name: "index_entries_on_tracker_id"
  end

  create_table "grades", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "tracker_id", null: false
    t.string "label", null: false
    t.string "color", null: false
    t.index ["label"], name: "index_grades_on_label"
    t.index ["tracker_id"], name: "index_grades_on_tracker_id"
  end

  create_table "trackers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id"
    t.string "name", null: false
    t.index ["user_id"], name: "index_trackers_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.uuid "verification_token", null: false
    t.datetime "verified_at"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "entries", "grades"
  add_foreign_key "entries", "trackers"
  add_foreign_key "grades", "trackers"
  add_foreign_key "trackers", "users"
end
