class Admin::CoursesController < ApplicationController
  before_action :get_all_subject, except: [:show, :destroy]
  before_action :init_course, only: [:edit, :update, :destroy, :show]
  before_action :require_admin
  respond_to :html, :json

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
    respond_modal_with @course
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "course.created_course"
      respond_modal_with @course, location: admin_root_path
    else
      flash.now[:danger] = t "course.create_course_failed"
      respond_modal_with @course, location: new_admin_course_path
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
    @user_courses = @course.user_courses
  end

  def destroy
    if @course.destroy
      flash[:success] = t "course.deleted_course"
      redirect_to admin_courses_path
    else
      flash.now[:danger] = t "course.delete_course_failed"
      redirect_to admin_course_path @course
    end
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
