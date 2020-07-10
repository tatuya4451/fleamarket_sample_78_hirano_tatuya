class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :saler_id, :integer, null:false
    add_column :items, :buyer_id, :integer
  end
end
