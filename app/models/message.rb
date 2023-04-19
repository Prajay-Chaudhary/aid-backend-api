class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  #method that takes in two user IDs as arguments 
  #and returns all the messages sent between those two users
  def self.conversation(user1,user2)
    return Message.where(sender_id: user1, receiver_id: user2).or(Message.where(sender_id: user2, receiver_id: user1))
  end
end