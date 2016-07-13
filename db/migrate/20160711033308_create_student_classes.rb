class CreateStudentClasses < ActiveRecord::Migration
  def change
    create_table :student_classes do |t|
      t.belongs_to :student, index: true, null: false
      t.belongs_to :class_period, index: true, null: false
    end
  end
end
