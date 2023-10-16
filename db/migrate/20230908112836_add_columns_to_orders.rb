class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :postal_code, :string
    add_column :orders, :address, :string
    add_column :orders, :name, :string
    add_column :orders, :payment_method, :integer
    add_column :orders, :postage, :integer
    add_column :orders, :billing, :integer
    add_column :orders, :customer_id, :integer
    add_column :orders, :status, :integer
  end
end
