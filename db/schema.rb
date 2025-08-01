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

ActiveRecord::Schema[8.0].define(version: 2025_07_30_161516) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_activities_on_lesson_id"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.text "text"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "curriculums", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_uploads", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "reporting_period_start"
    t.date "reporting_period_end"
  end

  create_table "lesson_attendances", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "sitting_lesson_id", null: false
    t.boolean "present", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_lesson_attendances_on_participant_id"
    t.index ["sitting_lesson_id"], name: "index_lesson_attendances_on_sitting_lesson_id"
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

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "state"
    t.string "urbanicity"
    t.string "setting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_organizations_on_discarded_at"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "study_id"
    t.string "category", default: "Youth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_participants_on_discarded_at"
    t.index ["study_id"], name: "index_participants_on_study_id", unique: true
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "questionnaire_id", null: false
    t.text "text"
    t.string "identifier", null: false
    t.integer "question_type"
    t.integer "number"
    t.boolean "required", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "answer_instructions"
    t.index ["identifier"], name: "index_questions_on_identifier", unique: true
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "responses", force: :cascade do |t|
    t.integer "questionnaire_id", null: false
    t.integer "participant_id"
    t.integer "sitting_id"
    t.json "answers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_responses_on_discarded_at"
    t.index ["participant_id"], name: "index_responses_on_participant_id"
    t.index ["questionnaire_id"], name: "index_responses_on_questionnaire_id"
    t.index ["sitting_id"], name: "index_responses_on_sitting_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "section_participant_responses", force: :cascade do |t|
    t.integer "section_participant_id", null: false
    t.integer "response_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["response_id"], name: "index_section_participant_responses_on_response_id"
    t.index ["section_participant_id"], name: "index_section_participant_responses_on_section_participant_id"
  end

  create_table "section_participants", force: :cascade do |t|
    t.integer "section_id", null: false
    t.integer "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_section_participants_on_participant_id"
    t.index ["section_id"], name: "index_section_participants_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.integer "curriculum_id", null: false
    t.integer "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.datetime "discarded_at"
    t.index ["curriculum_id"], name: "index_sections_on_curriculum_id"
    t.index ["discarded_at"], name: "index_sections_on_discarded_at"
    t.index ["site_id"], name: "index_sections_on_site_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.string "county"
    t.datetime "discarded_at"
    t.index ["code"], name: "index_sites_on_code", unique: true
    t.index ["discarded_at"], name: "index_sites_on_discarded_at"
    t.index ["organization_id"], name: "index_sites_on_organization_id"
  end

  create_table "sitting_lessons", force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.integer "sitting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_sitting_lessons_on_lesson_id"
    t.index ["sitting_id"], name: "index_sitting_lessons_on_sitting_id"
  end

  create_table "sittings", force: :cascade do |t|
    t.datetime "done_on"
    t.integer "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.string "name"
    t.datetime "discarded_at"
    t.string "lessons_covered", default: [], array: true
    t.index ["discarded_at"], name: "index_sittings_on_discarded_at"
    t.index ["section_id"], name: "index_sittings_on_section_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "user_sites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_user_sites_on_site_id"
    t.index ["user_id"], name: "index_user_sites_on_user_id"
  end

  create_table "user_sittings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "sitting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sitting_id"], name: "index_user_sittings_on_sitting_id"
    t.index ["user_id"], name: "index_user_sittings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "lessons"
  add_foreign_key "answers", "questions"
  add_foreign_key "lesson_attendances", "participants"
  add_foreign_key "lesson_attendances", "sitting_lessons"
  add_foreign_key "lessons", "curriculums"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "responses", "participants"
  add_foreign_key "responses", "questionnaires"
  add_foreign_key "responses", "sittings"
  add_foreign_key "section_participant_responses", "responses"
  add_foreign_key "section_participant_responses", "section_participants"
  add_foreign_key "section_participants", "participants"
  add_foreign_key "section_participants", "sections"
  add_foreign_key "sections", "curriculums"
  add_foreign_key "sections", "sites"
  add_foreign_key "sessions", "users"
  add_foreign_key "site_participants", "participants"
  add_foreign_key "site_participants", "sites"
  add_foreign_key "sitting_lessons", "lessons"
  add_foreign_key "sitting_lessons", "sittings"
  add_foreign_key "sittings", "sections"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "user_sites", "sites"
  add_foreign_key "user_sites", "users"
  add_foreign_key "user_sittings", "sittings"
  add_foreign_key "user_sittings", "users"
end
