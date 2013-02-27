# encoding: utf-8
#
class Mailer < ActionMailer::Base
  def donation_success payment
    @user = payment.user
    @project = payment.project
    mail(
      :subject => "【寸心网】感谢你的捐助！",
      :to => @user.email,
      :from => "no-reply@cunxin.org"
    )
  end
end
