class WelcomeMailer <ApplicationMailer
  def mailer(user)
    mail(to: user.email, subject: 'Registration',message: 'Successfully register')
  end
end
