class AddUnitToAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :unit, index: true, foreign_key: true
  end
end
