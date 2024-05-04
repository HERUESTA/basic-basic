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

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
