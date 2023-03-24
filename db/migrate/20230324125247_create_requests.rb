class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :request_type
      t.string :request_status
      t.string :title
      t.string :description
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
