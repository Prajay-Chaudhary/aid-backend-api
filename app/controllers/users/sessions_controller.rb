# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json


  # Password update without reset token
  def update_password
    user = User.find_by(email: params[:user][:email])

    if user.present? && user.valid_password?(params[:user][:current_password])
      if user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        # Password updated successfully
        render json: { notice: 'Password updated successfully' }, status: :ok
      else
        # Error updating password
        render json: { error: 'Error updating password' }, status: :unprocessable_entity
      end
    else
      # Invalid current password
      render json: { error: 'Invalid current password' }, status: :unprocessable_entity
    end
  end

  
  private

  #login
  def respond_with(current_user, _opts = {})
    render json: { 
        status: 200, 
        message: 'Logged in successfully.',
        user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] 
    }

  end

  #for destroying token after logout
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end


  def password_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
