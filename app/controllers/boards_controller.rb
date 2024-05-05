class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  before_action :check_user, only: %i[edit update destroy]
  before_action :require_login

  def index
    @boards = Board.all.includes(:user)
  end 

  def new
    @board = Board.new
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), flash: { success: '掲示板を更新しました' }
    else
      flash.now[:warning] = '掲示板を更新出来ませんでした'
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    # !をつけ、削除に失敗した場合例外を発生させる
    @board.destroy!
    # 削除に成功した場合、掲示板一覧ページにリダイレクトする
    redirect_to boards_path, flash: { success: '掲示板を削除しました' }
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, flash: { success: '掲示板を作成しました' }
    else
      flash.now[:warning] = '掲示板を作成出来ませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # 掲示板が存在する場合、その掲示板の情報を取得する
    @board = Board.find_by(id: params[:id])
    if @board
      @comment = Comment.new
      @comments = @board.comments.includes(:user).order(created_at: :desc)
    # 指定した掲示板が存在しない場合、掲示板一覧ページにリダイレクトする
    else
      redirect_to boards_path
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def check_user
    # current_userはDeviseなどの認証システムを使っている場合に利用可能    # @boardがnilでないことも確認
    if @board.nil? || current_user.id != @board.user_id
      raise ActiveRecord::RecordNotFound
    end
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
