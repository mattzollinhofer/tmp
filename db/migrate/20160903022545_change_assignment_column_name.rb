class ChangeAssignmentColumnName < ActiveRecord::Migration
  def change
    rename_column :assignments, :points_earned, :stars_possible
  end
end
