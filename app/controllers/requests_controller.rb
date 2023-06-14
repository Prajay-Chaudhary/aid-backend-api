class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_request, only: %i[ show update destroy ]

  def index
    # to get owner full_name using joins method
    @requests = Request.joins(:owner).select('requests.*, users.first_name || " " || users.last_name AS owner_full_name')
    add_image_urls_to_requests
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



  def show
    @request = Request.find(params[:id])
    add_image_urls_to_requests
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


  def update
    @request = Request.find(params[:id])
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


    # add image url to image by fetching from activeStorage
    def add_image_urls_to_requests
      base_url = 'http://127.0.0.1:3001'
      Array(@requests || @request).each do |request|
        image_urls = request.images.map { |image| "#{base_url}#{rails_blob_path(image, disposition: 'attachment', only_path: true)}" }
        request.image = image_urls.first if image_urls.present?
      end
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:request_type, :request_status, :title, :description, :address, :longitude, :latitude, :images, :owner_id)
    end
end
