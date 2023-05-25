class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: 'sender_id'
  belongs_to :receiver, class_name: "User", foreign_key: 'receiver_id'

  #method that takes in two user IDs as arguments 
  #and returns all the messages sent between those two users
  # def self.conversation(user1,user2)
  #   return Message.where(sender_id: user1, receiver_id: user2).or(Message.where(sender_id: user2, receiver_id: user1)).order(created_at: :desc)
  # end



  def self.conversation(user1, user2)
    Message.joins("INNER JOIN users ON messages.sender_id = users.id")
          .where("(messages.sender_id = :user1 AND messages.receiver_id = :user2) OR (messages.sender_id = :user2 AND messages.receiver_id = :user1)", user1: user1, user2: user2)
          .select("messages.*, users.first_name, users.last_name")
          .order(created_at: :desc)
  end



  # #get the list of users that the current user has intracted with
  # def self.interacted_users(user)
  #   #return Message.where(sender_id: user).or(Message.where(receiver_id: user)).order(created_at: :desc)
  #   return Message.where(sender_id: user).or(Message.where(receiver_id: user)).select(:sender_id, :receiver_id).order(created_at: :desc).collect{|x| [x.sender_id, x.receiver_id]}.flatten.uniq
  # end



  def self.interacted_users(user_id)
    messages = Message.where(sender_id: user_id).or(Message.where(receiver_id: user_id))
                      .group(:sender_id, :receiver_id)
                      .having('MAX(messages.created_at)')
                      .includes(:sender, :receiver)

      users_last_messages = messages.map do |message|
        interacted_user_id = (message.sender_id == user_id?) ? message.receiver_id : message.sender_id
        sent_by = (message.sender_id == user_id?)? "Me" : "Other" 

        {
          sender_id: message.sender_id,
          receiver_id: message.receiver_id,
          message: message.body,
          time_ago: ActionController::Base.helpers.time_ago_in_words(message.created_at),
          sender_first_name: message.sender.first_name,
          sender_last_name: message.sender.last_name,
        }
      end

    #unique_users = messages.distinct.pluck(:sender_id, :receiver_id).flatten.uniq - [user]

    # users_with_messages = users_last_messages + unique_users.map do |user_id|
    #   {
    #     sender_id: user_id,
    #     receiver_id: user_id,
    #     sender_first_name: User.find(user_id).first_name,
    #     sender_last_name: User.find(user_id).last_name,
    #   }
    # end

    return users_last_messages
  end





end