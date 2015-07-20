class UserSubjectsController < ApplicationController
  before_action :init_course
  
  def show
    @user_subject.subject.tasks.each do |task|
      @user_subject.user_tasks.find_or_initialize_by task_id: task.id, 
        course_id: @user_subject.course_id, 
        subject_id: @user_subject.subject_id, 
        user_id: current_user.id
    end
  end

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:success] = t "tasks.task_updated"
    else
      flash.now[:danger] = t "tasks.update_task_failed"
    end
    redirect_to [@course, @user_subject]
  end

  private
  def user_subject_params
    params.require(:user_subject).permit :id, user_tasks_attributes: [:id, :task_id, :status]
  end

  def init_course
    @user_subject = UserSubject.find params[:id]
    @user_course = current_user.user_courses.course_active.last
    @course = @user_course.course
  end
end
