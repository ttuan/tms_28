class Admin::CoursesController < ApplicationController
  before_action :get_all_subject, only: [:new, :create]

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "course.created_course"
      redirect_to admin_course_path @course
    else
      flash.now[:danger] = t "course.create_course_failed"
      render "new"
    end
  end

  private
  def course_params
    params.require(:course).permit :name, :description, subject_ids: []
  end

  def get_all_subject
    @subjects = Subject.all
  end  
end
