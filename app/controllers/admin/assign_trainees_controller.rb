class Admin::AssignTraineesController < ApplicationController
  before_action :require_admin
  before_action :init_course, only: [:edit, :update]

  def edit
    @users = User.avaiable_to_add(@course.id).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def update
    if @course.update_attributes user_ids_course_params
      flash[:success] = t "assign_trainees.success"
    else
      flash.now[:danger] = t "assign_trainees.fail"
    end
    redirect_to [:admin, @course]
  end

  private
  def user_ids_course_params
    params.require(:course).permit user_ids: []
  end

  def init_course
    @course = Course.find params[:course_id]
  end
end
