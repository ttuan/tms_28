class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper

  protected
  def after_sign_in_path_for resource
    current_user.supervisor? ? admin_root_path : root_path
  end

  def require_admin
    authenticate_user!
    redirect_to root_path unless current_user.supervisor?
  end
end
