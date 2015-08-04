class EmailRemoveUserFromCourse
  include Sidekiq::Worker

  def perform user_id, course_id
    user = User.find user_id
    course = Course.find course_id
    UserMailer.remove_user_from_course(user, course).deliver
  end
end
