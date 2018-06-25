class Admin::BaseController < ApplicationController
  layout "admin/index"
  before_action :admin_required
  include SessionsHelper
  protected
  def admin_required
    return if current_user && current_user.admin?
    flash[:warning] = t "admin.warning"
    redirect_to login_url
  end

  def sort_dir
    %w(asc desc).include?(params[:direction]) ? params[:direction] : "asc"
  end
end
