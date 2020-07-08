class AddDeliveryToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference(:items, :delivery, foreign_key: true, null: false)
  end
end
