class AddEarnedPointColumnsToClassAssignment < ActiveRecord::Migration
  def change
    add_column :class_assignments, :notes_earned, :integer
    add_column :class_assignments, :ixl_earned, :integer
  end
end
