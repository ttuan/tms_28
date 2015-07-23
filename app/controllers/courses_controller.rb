class CoursesController < ApplicationController
  def show
    @user_course = current_user.user_courses.course_active.last
    @course = @user_course.course
    @user_subjects = @user_course.user_subjects
  end
end
