require "test_helper"

class RequestTest < ActiveSupport::TestCase
  #test model validations
  test "should not save request without description" do
    request = Request.new
    assert_not request.save, "Saved the request without a description"
  end

  test "should not save request without user" do
    request = Request.new
    request.description = "Test description"
    assert_not request.save, "Saved the request without a user"
  end

  test "should not save request without request_status" do
    request = Request.new
    request.description = "Test description"
    request.request_status = "Unfulfilled"
    request.owner_id = 1
    assert_not request.save, "Saved the request without a status"
  end

end
