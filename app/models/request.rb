class Request < ApplicationRecord
  LIMIT = 5
  belongs_to :owner,  class_name: "User"
  has_many :fulfillments
  has_many :volunteers, through: :fulfillments, source: :user
  has_many_attached :images

  before_create :set_default_request_status

  #enums method in Rails to define enumerated values for attributes in your model.
  enum request_type: { onetime: 'One Time Help', material: 'Material Need'}
  enum request_status: {unfulfilled: 'unfulfilled',archived:'archived', fulfilled: 'Fulfilled'}

  #update situation to fulfilled if there is a fulfillment
  


  # def request_status
  #   if fulfillments.count >= LIMIT
  #     update(request_status: 'Fulfilled')
  #     self.request_status = 'Fulfilled'
  #   else 
  #     self.request_status = 'unfulfilled'
  #   end
  # end

  def update_request_status
    if fulfillments.count >= LIMIT
      update_column(:request_status, 'fulfilled')
    else
      update_column(:request_status, 'unfulfilled')
    end
  end


  #validations
  validates :description, presence: true
  validates :title, presence: true, length: {maximum: 50},on: :create, allow_nil: false
  validates :address, presence: true
  validates :description ,presence: true,length: {maximum: 300},on: :create, allow_nil: false
  validates :images, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  geocoded_by :address  # can also be an IP address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :reverse_geocode, if: :will_save_change_to_latitude? || :will_save_change_to_longitude?


  private

    #method ensures that the request_status attribute is set to :unfulfilled if it is currently nil, request_status is nil when request firstly created.
    def set_default_request_status
      self.request_status ||= :unfulfilled # ||= conditional assignment" operator.
    end
end


