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

ActiveRecord::Schema.define(version: 2019_11_09_220927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_id"
    t.string "name", null: false
    t.date "due_at"
    t.integer "notes_points_possible"
    t.integer "ixl_points_possible"
    t.integer "worksheet_points_possible"
    t.integer "star_points_possible"
    t.string "ixl_description"
    t.string "ixl_url"
    t.index ["unit_id"], name: "index_assignments_on_unit_id"
  end

  create_table "class_assignments", force: :cascade do |t|
    t.datetime "completed_at"
    t.integer "points_earned"
    t.integer "stars_earned"
    t.integer "student_class_id"
    t.integer "assignment_id"
    t.integer "notes_earned"
    t.integer "ixl_earned"
    t.index ["assignment_id"], name: "index_class_assignments_on_assignment_id"
    t.index ["student_class_id"], name: "index_class_assignments_on_student_class_id"
  end

  create_table "class_periods", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "period"
    t.index ["course_id"], name: "index_class_periods_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assignment_id"
    t.integer "year"
    t.index ["assignment_id"], name: "index_courses_on_assignment_id"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.integer "target_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "student_classes", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "class_period_id", null: false
    t.index ["class_period_id"], name: "index_student_classes_on_class_period_id"
    t.index ["student_id"], name: "index_student_classes_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "user_id"
    t.string "nickname"
    t.integer "graduation_year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_classes", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "class_period_id", null: false
    t.index ["class_period_id"], name: "index_teacher_classes_on_class_period_id"
    t.index ["teacher_id"], name: "index_teacher_classes_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.integer "order", null: false
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "mobile_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "type"
    t.string "nickname"
    t.integer "graduation_year"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "units"
  add_foreign_key "class_assignments", "assignments"
  add_foreign_key "class_assignments", "student_classes"
end
