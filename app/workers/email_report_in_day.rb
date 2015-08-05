class EmailReportInDay
  include Sidekiq::Worker

  def perform supervisor_id
    supervisor = User.find supervisor_id
    UserMailer.report_in_day(supervisor).deliver
  end
end
