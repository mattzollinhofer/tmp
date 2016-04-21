class AddCourseRefToAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :course, index: true, foreign_key: true
  end
end
