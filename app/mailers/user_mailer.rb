class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = 'http://median.com/user'
    mail(to: @user.email, subject: 'Welcome to Median')
  end
end
