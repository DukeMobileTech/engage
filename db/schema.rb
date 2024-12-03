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

ActiveRecord::Schema[8.0].define(version: 2024_12_03_195034) do
  create_table "curriculums", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.string "duration"
    t.text "content"
    t.integer "curriculum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculum_id"], name: "index_lessons_on_curriculum_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "study_id"
    t.string "category", default: "Youth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_id"], name: "index_participants_on_study_id", unique: true
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "curriculum_id", null: false
    t.integer "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculum_id"], name: "index_sections_on_curriculum_id"
    t.index ["site_id"], name: "index_sections_on_site_id"
  end

  create_table "site_participants", force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_site_participants_on_participant_id"
    t.index ["site_id"], name: "index_site_participants_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.string "state"
    t.string "county"
    t.string "urbanicity"
    t.string "setting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_sites_on_code", unique: true
  end

  add_foreign_key "lessons", "curriculums"
  add_foreign_key "sections", "curriculums"
  add_foreign_key "sections", "sites"
  add_foreign_key "site_participants", "participants"
  add_foreign_key "site_participants", "sites"
end
