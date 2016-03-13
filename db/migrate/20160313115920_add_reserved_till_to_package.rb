class AddReservedTillToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :reserved_till, :datetime
  end
end
