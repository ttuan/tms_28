class Admin::UserCoursesController < ApplicationController
  before_action :require_admin

  def destroy
    user_course = UserCourse.find params[:id]
    if user_course.destroy
      flash[:success] =  t "user_course.removed_user"    
    else
      flash.now[:danger] = t "user_course.remove_user_failed"
    end
    redirect_to :back
  end
end
