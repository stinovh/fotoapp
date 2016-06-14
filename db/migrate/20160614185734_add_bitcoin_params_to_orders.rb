class AddBitcoinParamsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :bitcoin_params, :string
  end
end
