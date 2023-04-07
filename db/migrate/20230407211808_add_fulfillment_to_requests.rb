class AddFulfillmentToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :fulfillment, :string
  end
end
