class Admin::SubjectsController < ApplicationController
  def new
    @subject = Subject.new
    @task = @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash.now[:success] = t "subjects.subject_success"
      redirect_to admin_subjects_path 
    else
      render "new"
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :day_work,
      tasks_attributes: [:id, :name, :_destroy, :description]
  end
end
