require "test_helper"


class FulfillmentControllerTest < ActionDispatch::IntegrationTest

  setup do
      sign_in users(:one)
      @fulfillment = fulfillment(:one)
      #define a fulfillment
      @fulfillment = Fulfillment.new
  end

end