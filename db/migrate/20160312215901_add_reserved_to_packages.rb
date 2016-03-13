class AddReservedToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :reserved, :boolean, default: false
  end
end
