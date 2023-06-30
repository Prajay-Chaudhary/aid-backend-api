class Users::PasswordResetsController < ApplicationController

  #send password reset link to user email
  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      @user.send_reset_password_instructions
      UserMailer.reset_password_email(@user).deliver_now
    end

    render json: { notice: 'Password reset instructions have been sent to your email' }, status: :ok
  end

end
