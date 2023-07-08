require 'test_helper'

class MessagesTest < ActiveSupport::TestCase
    #message model validations
    test "should not save message without body" do
        message = Message.new
        assert_not message.save, "Saved the message without a body"
    end

end