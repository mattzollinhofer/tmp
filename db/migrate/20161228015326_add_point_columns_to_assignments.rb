class AddPointColumnsToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :notes_points_possible, :integer
    add_column :assignments, :ixl_points_possible, :integer
    add_column :assignments, :worksheet_points_possible, :integer
    add_column :assignments, :star_points_possible, :integer
  end
end
