class ApplicationMailer < ActionMailer::Base
  default from: "welcome@median.com"
  layout 'mailer'
end