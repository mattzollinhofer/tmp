class RemoveColumnTeacherFromClassPeriods < ActiveRecord::Migration
  def change
    remove_column :class_periods, :teacher_id
  end
end
