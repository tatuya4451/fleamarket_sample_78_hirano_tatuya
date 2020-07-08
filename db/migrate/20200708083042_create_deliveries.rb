class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :method, null:false
      t.timestamps
    end
  end
end
