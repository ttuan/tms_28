class CoursesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_course = current_user.user_courses.course_active.last
    unless @user_course.nil?
      @course = @user_course.course
      @user_courses = @course.user_courses
      @course_subjects = @course.course_subjects
      @user_subjects = @user_course.user_subjects
      @activities = @course.activities.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end
end
