class BoardsController < ApplicationController
  before_action :require_login
  def index
    @boards = Board.all.includes(:user)
  end

  def new
    @board = Board.new
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

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
