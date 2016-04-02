class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.belongs_to :user, foreign_key: true
      t.string :nickname
      t.integer :graduation_year, null: false

      t.timestamps null: false
    end
  end
end
