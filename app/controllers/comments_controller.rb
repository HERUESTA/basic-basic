class CommentsController < ApplicationController
  skip_before_action :require_login

  def create
    @board = Board.find(params[:board_id])
    @comment = @board.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      @comment = Comment.new
    else
      flash.now[:alert] = @comment.errors.full_messages.join(', ')
    end
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy!
    respond_to do |format|
      format.turbo_stream { render status: :see_other }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
