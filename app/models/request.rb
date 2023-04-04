class Request < ApplicationRecord
  Limit = 5
  belongs_to :user



  #enums method in Rails to define enumerated values for attributes in your model.
  enum request_type: { onetime: 'One Time Help', material: 'Material Need'}
  enum request_status: {pending: 'Pending',archived:'archived', fulfilled: 'Fulfilled'}

  #update situation to fulfilled if there is a fulfillment

  # def request_status
  #   if updated_at < 24.hours.ago 
  #     update(request_status: 'archived')
  #     self.request_status = 'archived'
  #   elsif fulfillments.count >= Limit
  #     update(request_status: 'Fulfilled')
  #     self.request_status = 'Fulfilled'
  #   else 
  #     self.request_status = 'Pending'
  #   end
  # end


  #validations
  validates :description, presence: true
  validates :address, presence: true
  validates :description ,presence: true,length: {maximum: 300},on: :create, allow_nil: false


  geocoded_by :address  # can also be an IP address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :reverse_geocode, if: :will_save_change_to_latitude? || :will_save_change_to_longitude?
end
