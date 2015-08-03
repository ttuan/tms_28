class ReportAdminBeforeFinishJob < Struct.new(:course_id, :user_id)  
  def perform  
    course = Course.find course_id
    user = User.find user_id
    UserMailer.report_admin_before_finish(course, user).deliver
  end  
end
