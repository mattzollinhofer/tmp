class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :points_earned
      t.integer :points_possible
      t.integer :order
      t.datetime :due_at
      t.datetime :completed_at
      t.string :time_zone_id

      t.timestamps null: false
    end
  end
end
