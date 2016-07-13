class CreateTeacherClasses < ActiveRecord::Migration
  def change
    create_table :teacher_classes do |t|
      t.belongs_to :teacher, index: true, null: false
      t.belongs_to :class_period, index: true, null: false
    end
  end
end
