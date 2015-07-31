class Admin::UsersController < ApplicationController
  before_action :require_admin
  load_and_authorize_resource
  respond_to :html, :json
  
  def index
    @search = User.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.per_page
    @search.build_condition
    @search.build_sort if @search.sorts.empty?
  end

  def new
    @user = User.new
    respond_modal_with @user
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin.user.create_success"
      respond_modal_with @user, location: admin_root_url
    else
      flash.now[:danger] = t "admin.user.create_fail"
      respond_modal_with @user, location: new_admin_user_path
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
