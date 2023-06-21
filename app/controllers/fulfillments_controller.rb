class FulfillmentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_fulfillment, only: %i[ show update destroy ]

  # GET /fulfillments
  def index
    @fulfillments = Fulfillment.all

    render json: @fulfillments
  end

  # GET /fulfillments/1
  def show
    @fulfillment = Fulfillment.find(params[:id])
    render json: @fulfillment
  end

  def my_fulfillments
    @fulfillments = current_user.fulfillments
    render json: @fulfillments
  end

  # POST /fulfillments
  # def create
  #   @fulfillment = Fulfillment.new(fulfillment_params)
  #   @fulfillment.user = current_user
  #   @fulfillment.request = Request.find(params[:request_id])

  #   if @fulfillment.save
  #     render json: @fulfillment, status: :created, location: @fulfillment
  #   else
  #     render json: @fulfillment.errors, status: :unprocessable_entity
  #   end
  # end

  #POST /fulfillments, it will check if a fulfillment object is not created for the current user then it will create a new one and save to the db else, message.
  def create
    @fulfillment = Fulfillment.find_by(user_id: params[:user_id])
    if @fulfillment.nil?
      @fulfillment = Fulfillment.new(fulfillment_params)
      @fulfillment.user = current_user
      @fulfillment.request = Request.find(params[:request_id])

      if @fulfillment.save
        render json: @fulfillment, status: :created, location: @fulfillment
      else
        render json: @fulfillment.errors, status: :unprocessable_entity
      end
    else
      render json: {
        status: 422,
        message: 'A fulfillment has already been created with this user.'
      }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /fulfillments/1
  def update
    user = current_user
    @fulfillment = Fulfillment.find(params[:id])
    if @fulfillment.update(fulfillment_params)
      render json: @fulfillment
    else
      render json: @fulfillment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fulfillments/1
  def destroy
    @fulfillment = Fulfillment.find(params[:id])
    @fulfillment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fulfillment
      @fulfillment = Fulfillment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fulfillment_params
      params.require(:fulfillment).permit(:request_id, :user_id, :fulfilled_time)
    end
end