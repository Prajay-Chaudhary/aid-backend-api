class Fulfillment < ApplicationRecord
  belongs_to :user
  belongs_to :request
  after_create_commit :update_request_status


  private

  def update_request_status
    request.update_request_status
  end
end