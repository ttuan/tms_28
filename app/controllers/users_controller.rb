class UsersController < ApplicationController
  before_action :init_user, only: [:show, :edit]
  before_action :correct_user, only: [:edit]
  before_action :authenticate_user!
  
  private
  def init_user
    @user = User.find params[:id]
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end
end
