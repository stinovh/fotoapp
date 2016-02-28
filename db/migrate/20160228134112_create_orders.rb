class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :package, index: true, foreign_key: true
      t.string :full_name
      t.string :email
      t.text :notification_params
      t.string :status
      t.string :transaction_id
      t.datetime :purchased_at

      t.timestamps null: false
    end
  end
end
