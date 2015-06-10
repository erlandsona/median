class WelcomeMailer < ApplicationMailer::Base
  default (:from => "welcome@median.com", :to=>"#{@user.email}")
  layout 'mailer'

  def welcome_mailer(welcome)
    @welcome = welcome
    @url  = "http://median.com/"
    mail(:subject => "Welcome")
  end
end