class UserMailer < ApplicationMailer
  default from: 'contact@prajaychaudhary.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Aid Your Neighbour App!')
  end
end
