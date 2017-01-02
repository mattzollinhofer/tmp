class AddIxlDescriptionColumnToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :ixl_description, :string
    add_column :assignments, :ixl_url, :string
  end
end
