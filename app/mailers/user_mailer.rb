class UserMailer < ApplicationMailer
  def create_account user
    @user = user
    mail to: user.email, subject: I18n.t("mailer.subject")
  end
end
