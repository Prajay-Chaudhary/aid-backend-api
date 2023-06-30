class UserMailer < ApplicationMailer
  default from: 'contact@prajaychaudhary.com'

  #welcome email
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Aid Your Neighbour App!')
  end

  #rest password mailer
  def reset_password_email(user)
    @user = user
    @reset_password_url = edit_user_password_url(reset_password_token: @user.reset_password_token)
    mail(to: @user.email, subject: 'Reset Your Password')
  end
end
