class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:success] = t('admin.user_sessions.not_authenticated')
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, success: t('admin.base_controller.no_permission') unless current_user.admin?
  end
end
