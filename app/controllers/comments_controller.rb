class CommentsController < ApplicationController
  skip_before_action :require_login

  def create
    @board = Board.find(params[:board_id])
    @comment = @board.comments.build(comment_params)
    @comment.user = current_user # ここでuser_idを紐づける

    if @comment.save
      redirect_to board_path(@board), flash: { success: 'コメントを作成しました' }
    else
      @comments = @board.comments.includes(:user)
      flash.now[:warning] = 'コメントを作成出来ませんでした'
      render :'boards/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    # コメントの作成に必要なパラメーターを指定します
    params.require(:comment).permit(:body)
  end
end
