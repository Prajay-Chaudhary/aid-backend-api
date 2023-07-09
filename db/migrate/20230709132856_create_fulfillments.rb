class CreateFulfillments < ActiveRecord::Migration[7.0]
  def change
    create_table :fulfillments do |t|
      t.integer :user_id, null: false
      t.integer :request_id, null: false
      t.datetime :fulfilled_time, precision: nil, default: -> { "CURRENT_TIMESTAMP" }

      t.index :request_id
      t.index :user_id

      t.timestamps
    end
  end
end
