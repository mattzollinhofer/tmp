class RemoveEmailAddressFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :email_address, :string
  end
end
