class Admin::SubjectsController < ApplicationController
  def show
     @subject = Subject.find params[:id]
  end

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

  def edit
    @subject = Subject.find params[:id]
  end

  def destroy
    if Subject.find(params[:id]).destroy
      flash[:success] = t "subject_deleted"
      redirect_to subjects_url
    else
      flash.now[:danger] = t "subject_not_deleted"
      redirect_to subjects_url
    end
  end

  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes subject_params
      flash.now[:success] = t "subjects.subject_updated"
      redirect_to admin_subjects_path 
    else
      render "edit"
    end
  end

  private
  def subject_params
    params.require(:subject).permit :id, :name, :description, :day_work,
      tasks_attributes: [:id, :name, :_destroy, :description]
  end
end
