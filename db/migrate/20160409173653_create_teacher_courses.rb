class CreateTeacherCourses < ActiveRecord::Migration
  def change
    create_table :teacher_courses do |t|
      t.belongs_to :teacher, index: true, null: false
      t.belongs_to :course, index: true

      t.timestamps null: false
    end
  end
end
