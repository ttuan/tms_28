class EmailReport
  include Sidekiq::Worker

  def perform
    @supervisors = User.supervisors
    reports = Activity.in_day.order("user_id DESC")
    
    @supervisors.each do |supervisor|
      UserMailer.report_in_day(supervisor, reports).deliver
    end
  end
end
