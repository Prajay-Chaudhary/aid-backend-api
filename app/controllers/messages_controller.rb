class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update destroy ]

  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end


    #user's all messages
  def my_messages
    @sent_messages = current_user.sent_messages
    @received_messages = current_user.received_messages
    render json: {
      sent_messages: @sent_messages,
      received_messages: @received_messages
    }
  end

  # GET /messages/1
  def show
    @message = Message.find(params[:id])
    render json: @message
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.fulfillment = Fulfillment.find(params[:fulfillment_id])

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
