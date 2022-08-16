# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_16_074650) do
  create_table "allowed_syncers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string "email_address"
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_emails_on_person_id"
  end

  create_table "meeting_attendees", force: :cascade do |t|
    t.integer "email_id", null: false
    t.integer "person_id", null: false
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_id"], name: "index_meeting_attendees_on_email_id"
    t.index ["organization_id"], name: "index_meeting_attendees_on_organization_id"
    t.index ["person_id"], name: "index_meeting_attendees_on_person_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "subject"
    t.datetime "start_date"
    t.string "event_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_uid"], name: "index_meetings_on_event_uid", unique: true
  end

  create_table "organization_email_mappings", force: :cascade do |t|
    t.string "regex"
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_email_mappings_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "type"
    t.string "name"
    t.text "description"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_people_on_organization_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  add_foreign_key "emails", "people"
  add_foreign_key "meeting_attendees", "emails"
  add_foreign_key "meeting_attendees", "organizations"
  add_foreign_key "meeting_attendees", "people"
  add_foreign_key "organization_email_mappings", "organizations"
  add_foreign_key "people", "organizations"
end
