class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.integer :order, null: false
      t.belongs_to :course

      t.timestamps null: false
    end
  end
end
