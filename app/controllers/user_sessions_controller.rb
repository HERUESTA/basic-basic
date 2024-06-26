class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to boards_path, flash: { success: 'ログインしました' }
    else
      flash.now[:warning] = 'ログインに失敗しました'
      render :new, status:  :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, flash: { success: 'ログアウトしました' }
  end
end
