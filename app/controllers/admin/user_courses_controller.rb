class Admin::UserCoursesController < ApplicationController
  before_action :require_admin

  def destroy
    if UserCourse.find(params[:id]).destroy
      flash[:success] =  t "user_course.removed_user"    
    else
      flash.now[:danger] = t "user_course.remove_user_failed"
    end
    redirect_to :back
  end
end
