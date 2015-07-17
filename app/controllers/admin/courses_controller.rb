class Admin::CoursesController < ApplicationController
  before_action :get_all_subject, except: [:show, :destroy]
  before_action :init_course, only: [:edit, :update, :destroy, :show]

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

  def update
    if @course.update_attributes course_params
      flash[:success] = t "course.updated_course"
      redirect_to admin_course_path @course
    else
      flash.now[:danger] = t "course.update_course_failed"
      render "edit"
    end
  end

  def show
    @course_subjects = @course.course_subjects
    @users = @course.users
  end

  private
  def course_params
    params.require(:course).permit :name, :description, subject_ids: []
  end

  def get_all_subject
    @subjects = Subject.all
  end  

  def init_course
    @course = Course.find params[:id]
  end
end
