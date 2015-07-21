class Admin::UsersController < ApplicationController
  before_action :require_admin
  load_and_authorize_resource

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin.user.create_success"
      redirect_to @user
    else
      flash.now[:danger] = t "admin.user.create_fail"
      render "new"
    end
  end

  def update
    if @user.update_attributes set_admin_params
      flash[:success] = t "admin.user.update_success"
    else
      flash.now[:danger] = t "admin.user.update_fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_root_url}
      format.js
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.user.del_success"
    else
      flash.now[:danger] = t "admin.user.del_fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_root_url}
      format.js
    end
  end

  private
  def set_admin_params
    params.require(:user).permit :supervisor
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :supervisor
  end
end
