class RemoveUnnecessaryAttributesFromAssignment < ActiveRecord::Migration
  def change
    remove_column :assignments, :completed_at, :datetime
    remove_column :assignments, :due_at, :datetime
    remove_column :assignments, :time_zone_id, :string
  end
end
