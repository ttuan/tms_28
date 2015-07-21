class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :init_user, only: [:update, :destroy]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def update
    if @user.update_attributes user_params
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
  def user_params
    params.require(:user).permit :supervisor
  end

  def init_user
    @user = User.find params[:id]
  end
end
