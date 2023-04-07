class AddUserToFulfillments < ActiveRecord::Migration[7.0]
  def change
    add_reference :fulfillments, :user, null: false, foreign_key: true
  end
end
