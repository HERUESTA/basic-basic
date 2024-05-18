class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params).decorate
    if @user.save
      redirect_to root_path, flash: { success: 'ユーザー登録が完了しました' }
    else
      flash.now[:warning] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    render :'profiles/show'
  end

  def edit
    @user = current_user
    render :'profiles/edit'
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, flash: { success: 'ユーザーを更新しました' }
    else
      flash.now[:warning] = 'ユーザーを更新出来ませんでした'
      render :'profiles/edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :email, :password, :password_confirmation, :last_name, :first_name)
  end
end
