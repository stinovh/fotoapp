class AddPriceNowCentsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :price_now_cents, :integer
  end
end
