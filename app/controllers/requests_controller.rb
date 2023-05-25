class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_request, only: %i[ show update destroy ]

  # GET /requests
  def index
    @requests = Request.all

    render json: @requests
  end

  #index current user requests
  def my_requests
    @requests = current_user.owned_requests
    render json: @requests
  end

    #user who has made the request
  def request_owner
    @request = Request.find(params[:id])
    @owner = @request.owner
    render json: @owner
  end

  # GET /requests/1
  def show
    @request = Request.find(params[:id])
    render json: @request
  end

  # POST /requests
  def create
    @request = Request.new(request_params)
    @request.owner_id = current_user.id

    if @request.save
      render json: @request, status: :created #, location: @request
    else
      render json: @request.errors.full_messages.to_sentence, status: 422
    end
  end

  # PATCH/PUT /requests/1
  # def update
  #   if @request.update(request_params)
  #     render json: @request
  #   else
  #     render json: @request.errors, status: :unprocessable_entity
  #   end
  # end

  def update
    @request = Request.find(params[:id])
    #@request.user = current_user
    @request.owner_id = current_user.id
    if @request.update(request_params)
      render json: @request
    else
      render json: { error: @request.errors.full_messages.to_sentence }, status: 422
    end
  end

  # DELETE /requests/1
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    render json: {
     status: 200,
     message: 'request deleted.'
   }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:request_type, :request_status, :title, :description, :address, :longitude, :latitude, :image, :owner_id)
    end
end
