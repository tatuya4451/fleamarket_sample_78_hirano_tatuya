class AddTradingStatusToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :trading_status, :integer, null: false
  end
end
