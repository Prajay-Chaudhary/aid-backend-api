class FulfillmentsController < ApplicationController
  before_action :set_fulfillment, only: %i[ show update destroy ]

  # GET /fulfillments
  def index
    @fulfillments = Fulfillment.all

    render json: @fulfillments
  end

  # GET /fulfillments/1
  def show
    render json: @fulfillment
  end

  # POST /fulfillments
  def create
    @fulfillment = Fulfillment.new(fulfillment_params)

    if @fulfillment.save
      render json: @fulfillment, status: :created, location: @fulfillment
    else
      render json: @fulfillment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fulfillments/1
  def update
    if @fulfillment.update(fulfillment_params)
      render json: @fulfillment
    else
      render json: @fulfillment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fulfillments/1
  def destroy
    @fulfillment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fulfillment
      @fulfillment = Fulfillment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fulfillment_params
      params.require(:fulfillment).permit(:text)
    end
end
