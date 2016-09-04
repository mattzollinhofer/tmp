class AddColumnPeriodToClassPeriods < ActiveRecord::Migration
  def change
    add_column :class_periods, :period, :integer
  end
end
