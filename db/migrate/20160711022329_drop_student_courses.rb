class DropStudentCourses < ActiveRecord::Migration
  def up
    drop_table :student_courses
  end

  def down
    raise 'Irreversible migration: drop table student_courses'
  end
end
