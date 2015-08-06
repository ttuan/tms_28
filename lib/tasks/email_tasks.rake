desc "report supervisor"
task report_supervisor: :environment do
  @courses_active = Course.course_active
  @courses_active.each do |course|
    course.users.list_supervisor(course.id).each do |supervisor|
      UserMailer.report_supervisor(supervisor, course).deliver_now
    end
  end
end
