require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
    setup do
        #login user
        new_user_session_url users(:one)
        @user = users(:one)
    end

    test "should get index" do
        get users_url
        assert_response 200
    end

    test "should show user" do
        get user(@user)
        assert_response :success
    end

    test "should not create new if signed out" do
        destroy_user_session_url users(:one)
        assert_no_difference('User.count') do
            post users_url, params: { user: { }}
        end
    end
end
