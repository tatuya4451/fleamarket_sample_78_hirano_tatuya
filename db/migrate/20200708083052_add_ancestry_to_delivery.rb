class AddAncestryToDelivery < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :ancestry, :string
    add_index :deliveries, :ancestry
  end
end

