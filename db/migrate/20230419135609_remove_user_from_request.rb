class RemoveUserFromRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :user_id
  end
end
