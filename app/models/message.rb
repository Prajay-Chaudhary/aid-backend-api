class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: 'sender_id'
  belongs_to :receiver, class_name: "User", foreign_key: 'receiver_id'

  #method that takes in two user IDs as arguments 
  #and returns all the messages sent between those two users
  # def self.conversation(user1,user2)
  #   return Message.where(sender_id: user1, receiver_id: user2).or(Message.where(sender_id: user2, receiver_id: user1)).order(created_at: :desc)
  # end



  def self.conversation(user1, user2)
   conversations = Message.joins("INNER JOIN users ON messages.sender_id = users.id")
                          .where("(messages.sender_id = :user1 AND messages.receiver_id = :user2) OR (messages.sender_id = :user2 AND messages.receiver_id = :user1)", user1: user1, user2: user2)
                          .select("messages.*, users.first_name, users.last_name, messages.body, messages.created_at")
                          .order(created_at: :desc)


      users_conversations = conversations.map do |conversation|

        sent_by = (conversation.sender_id == user1) ? "Me" : "Other"
        message_created_on = conversation.created_at.strftime("%d %B, %Y")
        message_created_at = conversation.created_at.strftime("%I:%M %p")
        {
          message_body: conversation.body,
          sender_first_name: conversation.first_name,
          sender_last_name: conversation.last_name,
          sender_id: conversation.sender_id,
          receiver_id: conversation.receiver_id,
          sent_by: sent_by,
          message_created_on: message_created_on,
          message_created_at: message_created_at
        }
      end
      users_conversations

  end



  #get the list of users that the current user has intracted with
  def self.interacted_users(user_id)
      messages = Message.where(sender_id: user_id).or(Message.where(receiver_id: user_id)).distinct.order(created_at: :desc).uniq{|n| [n.sender_id,n.receiver_id].sort}
      #messages = Message.where(sender_id: user_id).or(Message.where(receiver_id: user_id)).uniq{|n| [n.sender_id,n.receiver_id]}.order(created_at: :desc).distinct.limit(1).last      
      users_messages = messages.map do |message|
        interacted_user_id = (message.sender_id == user_id) ? message.receiver_id : message.sender_id
        sent_by = (message.sender_id == user_id)? "Me" : "Other"
        interacted_fname = if message.sender_id == user_id
                            message.receiver.first_name
                          else
                            message.sender.first_name
                          end
          
        interacted_lname = if message.sender_id == user_id
                    message.receiver.last_name
                  else
                    message.sender.last_name
                  end
        #todo
        message_body = message.body.truncate(10) # Limit message body to 10 characters

        {
          interacted_user_id: interacted_user_id,
          interacted_fname: interacted_fname,
          interacted_lname: interacted_lname,
          message_body: message_body,
          time_ago: ActionController::Base.helpers.time_ago_in_words(message.created_at),

          sent_by: sent_by
        }
      end


    return users_messages
  end





end