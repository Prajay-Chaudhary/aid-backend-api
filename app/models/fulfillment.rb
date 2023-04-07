class Fulfillment < ApplicationRecord
  belongs_to :request
  belongs_to :user 

  validates :user , uniqueness: {scope: :request}
end
