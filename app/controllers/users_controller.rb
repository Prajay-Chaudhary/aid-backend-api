class UsersController < ApplicationController


  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     #WelcomeEmailJob.perform_later(@user)
  #     UserMailer.welcome_email(user).deliver_now
  #     render json: @user, status: :created
  #   else
  #     render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

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


  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :file)
  end
end
