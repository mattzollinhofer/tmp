class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.belongs_to :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
