class RemovePointColumnsFromAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :stars_possible, :integer
    remove_column :assignments, :points_possible, :integer
  end
end
