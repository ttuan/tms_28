class UsersController < ApplicationController
  before_action :init_user, only: [:show, :edit]
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def show
    @user_course = @user.user_courses.course_active_by_user.last
    @course = @user_course.course unless @user_course.nil?
  end
  
  def update
    if @user.update_attributes user_params
      sign_in @user, bypass: true
      flash[:success] = t "user.update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "user.updated_fail"
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def init_user
    @user = User.find params[:id]
  end
end
