class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by_email(params[:email])

    # 有効期限つきのリセットコードを生成し、ユーザーにメールで送信する
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, flash: { success: 'パスワードリセット手順を送信しました' }
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    p @user
    p @user.password
    if @user.change_password(params[:user][:password])
      redirect_to login_path, flash: { success: 'パスワードを変更しました' }
    else
      render action: 'edit'
    end
  end
end
