class AddFulfilledTimeToFulfillments < ActiveRecord::Migration[7.0]
  def change
    add_column :fulfillments, :fulfilled_time, :timestamps
    change_column_default :fulfillments, :fulfilled_time, -> { 'CURRENT_TIMESTAMP' }
  end
end
