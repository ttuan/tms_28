class SubjectsController < ApplicationController
  before_action :init_course

  def update
    if @user_subject.update_attributes status: true
      flash[:success] = t "subjects.subject_finised"
    else
      flash.now[:danger] = t "subjects.subject_finish_failed"
    end
    redirect_to [@course, @user_subject]
  end

  private
  def init_course
    @user_subject = UserSubject.find params[:user_subject_id]
    @user_course = current_user.user_courses.course_active.last
    @course = @user_course.course
  end
end
