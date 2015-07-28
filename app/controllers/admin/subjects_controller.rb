class Admin::SubjectsController < ApplicationController
  before_action :init_subject, only: [:show, :edit, :update, :destroy]
  before_action :require_admin
  respond_to :html, :json

  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
    @task = @subject.tasks.build
    respond_modal_with @subject
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "subjects.subject_success"
      respond_modal_with @subject, location: admin_root_url
    else
      flash.now[:danger] = t "subjects.subject_not_success"
      render "new"
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "subjects.subject_deleted"
    else
      flash.now[:danger] = t "subjects.subject_not_deleted"
    end
    redirect_to admin_subjects_url
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subjects.subject_updated"
      redirect_to admin_subject_path @subject 
    else
      flash.now[:danger] = t "subjects.subject_not_updated"
      render "edit"
    end
  end

  private
  def subject_params
    params.require(:subject).permit :id, :name, :description, :day_work,
      tasks_attributes: [:id, :name, :_destroy, :description]
  end

  def init_subject
    @subject = Subject.find params[:id]
  end
end
