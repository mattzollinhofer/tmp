class AddColumnDueAtToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :due_at, :date
  end
end
