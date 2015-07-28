class Admin::CourseSubjectsController < ApplicationController
  before_action :require_admin
  before_action :test_active, only: :update
  before_action :active_params, only: :update

  def show
    @course_subject = CourseSubject.find params[:id]
    @subject = @course_subject.subject
    @course = @course_subject.course
  end

  def update
    @course_subject = CourseSubject.find params[:course_subject_id]
    @subject = @course_subject.subject
    @course = @course_subject.course
    if @course_subject.update_attributes active: active_params
      flash[:success] = t "course_subject.update_success"
    else
      flash.now[:danger] = t "course_subject.update_fail"
    end
    redirect_to [:admin, @course, @course_subject]
  end

  private
  def active_params
    params[:active] == Settings.start ? Settings.value_false : Settings.value_true
  end

  def test_active
    redirect_to :back unless Settings.active.include? params[:active]
  end
end
