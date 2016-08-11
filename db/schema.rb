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

ActiveRecord::Schema.define(version: 20160714182427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer  "points_earned"
    t.integer  "points_possible"
    t.integer  "order"
    t.datetime "due_at"
    t.datetime "completed_at"
    t.string   "time_zone_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "course_id"
  end

  add_index "assignments", ["course_id"], name: "index_assignments_on_course_id", using: :btree

  create_table "class_periods", force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "class_periods", ["course_id"], name: "index_class_periods_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "assignment_id"
    t.integer  "year"
  end

  add_index "courses", ["assignment_id"], name: "index_courses_on_assignment_id", using: :btree

  create_table "student_classes", force: :cascade do |t|
    t.integer "student_id",      null: false
    t.integer "class_period_id", null: false
  end

  add_index "student_classes", ["class_period_id"], name: "index_student_classes_on_class_period_id", using: :btree
  add_index "student_classes", ["student_id"], name: "index_student_classes_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.integer  "graduation_year", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "teacher_classes", force: :cascade do |t|
    t.integer "teacher_id",      null: false
    t.integer "class_period_id", null: false
  end

  add_index "teacher_classes", ["class_period_id"], name: "index_teacher_classes_on_class_period_id", using: :btree
  add_index "teacher_classes", ["teacher_id"], name: "index_teacher_classes_on_teacher_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "order",      null: false
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "mobile_number"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "type"
    t.string   "nickname"
    t.integer  "graduation_year"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
