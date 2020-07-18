class RemoveTradingStatusFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :trading_status, :integer, null: false
  end
end
