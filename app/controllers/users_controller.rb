class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  respond_to :html, :json
  
  def show
    @user_course = @user.user_courses.course_active.last
    @user_subjects = @user_course.user_subjects unless @user_course.nil?
    @activities = @user.activities.last Settings.limit_activities
  end
  
  def edit
    respond_modal_with @user
  end

  def update
    if @user.update_attributes user_params
      sign_in @user, bypass: true
      flash[:success] = t "user.update_success"
      respond_modal_with @user, location: @user
    else
      flash.now[:danger] = t "user.updated_fail"
      respond_modal_with @user, location: edit_user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end
end
