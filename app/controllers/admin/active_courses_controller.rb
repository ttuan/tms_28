class Admin::ActiveCoursesController < ApplicationController
  before_action :require_admin
  before_action :check_active

  def update
    @course = Course.find params[:course_id]
    if @course.update_attributes status: active_params
      flash[:success] = t "active_course.update_success"
    else
      flash.now[:danger] = t "active_course.update_fail"
    end
    redirect_to [:admin, @course]
  end

  private
  def active_params
    params[:active] == Settings.start ? Settings.value_false : Settings.value_true
  end

  def check_active
    redirect_to :back unless Settings.active_course.include? params[:active]
  end
end
