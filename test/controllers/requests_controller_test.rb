require "test_helper"

class RequestsControllerTest < ActionDispatch::IntegrationTest

  setup do
    new_user_session_url users(:one)
    @request = requests(:one)
  end

  test "should get index" do
    get requests_url
    assert_response :success
  end


  test "should show request" do
    destroy_user_session_url users(:one)
    get request(@request)
    assert_response :success
  end

end
