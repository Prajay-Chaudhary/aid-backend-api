class RemoveUserIdAndFulfillmentIdFromMessage < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :user_id
    remove_column :messages, :fulfillment_id
  end
end
