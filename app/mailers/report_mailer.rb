class ReportMailer < ApplicationMailer
	default from: "matiasdim3@gmail.com"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'We have a new report of your pet!')
  end
end
