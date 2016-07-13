class ChangeTeacherCoursesToClassPeriods < ActiveRecord::Migration
  def change
    rename_table :teacher_courses, :class_periods
  end
end
