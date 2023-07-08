require 'test_helper'

class FulfillmentsTest < ActiveSupport::TestCase
    #test model validations

    test "should not save fulfillment without user" do
        fulfillment = Fulfillment.new
        assert_not fulfillment.save, "Saved the fulfillment without a user"
    end

end