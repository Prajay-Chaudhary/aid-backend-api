class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update destroy ]
  before_action :authenticate_user!


  
  # GET /messages
  def index
    @messages = Message.interacted_users(current_user.id)
    render json: @messages
  end


  #fetch conversation between two users
  def conversation
    user1 = current_user.id
    user2 = params[:user_id]
    @messages = Message.conversation(user1, user2)
    render json: @messages
  end
  



  # GET /messages/1
  def show
    @message = Message.find(params[:id])
    render json: @message
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.sender = current_user

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
        params.require(:message).permit(:body, :sender_id, :receiver_id)
    end
end