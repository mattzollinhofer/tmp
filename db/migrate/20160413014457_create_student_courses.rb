class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.belongs_to :student, index: true, null: false
      t.belongs_to :course, index: true, null: false

      t.timestamps null: false
    end
  end
end
