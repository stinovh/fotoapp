class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.text :description
      t.integer :start_price_cents
      t.integer :minimum_price_cents
      t.timestamp :start_time
      t.timestamp :end_time
      t.boolean :sold, default: false

      t.timestamps null: false
    end
  end
end
