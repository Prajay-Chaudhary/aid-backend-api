# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

    def welcome_email(user)
    @user = user
    UserMailer.with(user: User.first).welcome_email
  end
end
