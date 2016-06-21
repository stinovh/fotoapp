class AddConfirmationsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmations, :integer
  end
end
