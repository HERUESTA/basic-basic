class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :success, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path, flash: { warning: 'ログインしてください' }
  end
end
