require "test_helper"

class UserTest < ActiveSupport::TestCase
  #validates presence of username
  test "should not save user without username" do
    user = User.new
    assert_not user.save, "Saved the user without a username"
  end
  #validates presence of email
  test "should not save user without email" do
    user = User.new
    assert_not user.save, "Saved the user without a email"
  end
  #validates presence of password
  test "should not save user without password" do
    user = User.new
    assert_not user.save, "Saved the user without a password"
  end

  test "email should be unique" do
    user= User.new( email: "test@gmail.com" )
    user2 = User.new( email: "test@gmail.com" )
    assert_not user2.valid?
  end

end
