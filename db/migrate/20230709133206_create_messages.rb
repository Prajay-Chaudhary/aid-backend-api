class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :sender_id
      t.integer :receiver_id

      t.index :receiver_id, name: "index_messages_on_receiver_id"
      t.index :sender_id, name: "index_messages_on_sender_id"

      t.timestamps
    end
  end
end
