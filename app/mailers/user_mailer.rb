class UserMailer < ApplicationMailer
  def create_account user
    @user = user
    mail to: user.email, subject: I18n.t("mailer.subject.create_account")
  end

  def assign_trainee user, course
    @user = user
    @course = course
    mail to: user.email, subject: I18n.t("mailer.subject.assign_trainee")
  end

  def remove_user_from_course user, course
    @user = user
    @course = course
    mail to: user.email, subject: I18n.t("mailer.subject.remove_user")
  end

  def report_admin_before_finish course, user
    @course = course
    @user = user
    mail to: user.email, subject: I18n.t("mailer.report_admin_before_finish")
  end

  def report_in_day supervisor
    @activities = Activity.in_day Date.today
    @supervisor = supervisor
    mail to: supervisor.email, subject: I18n.t("mailer.subject.report_in_day", today: Date.today)
  end
end
