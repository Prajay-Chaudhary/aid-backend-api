class RemoveFulfillmentFromRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :fulfillment
  end
end
