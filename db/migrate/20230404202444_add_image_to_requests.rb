class AddImageToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :image, :string
  end
end
