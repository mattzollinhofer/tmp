class AddColumnNameToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :name, :string, null: false
  end
end
