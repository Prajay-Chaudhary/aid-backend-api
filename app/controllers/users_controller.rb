class UsersController < ApplicationController


  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    add_file_urls_to_users
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end

  private

    def set_user
      @user = User.find_by_id(params[:id])  
    end

    def add_file_urls_to_users
      base_url = 'http://127.0.0.1:3001'
      Array(@users || @user).each do |user|
        file_urls = user.files.map { |file| "#{base_url}#{rails_blob_path(file, disposition: 'attachment', only_path: true)}" }
        user.file = file_urls.first if file_urls.present?
      end
    end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :files)
  end
end

