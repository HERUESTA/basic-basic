class BookmarksController < ApplicationController
  skip_before_action :require_login

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(20)
  end

  def show
    render :index
  end

  def create
    @bookmark = current_user.bookmarks.build(board_id: params[:board_id])
    @bookmark.save!
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(board_id: params[:id])
    @bookmark.destroy!
    respond_to do |format|
      format.turbo_stream
    end
  end

  def bookmark_params
    params.require(:bookmark).permit(:board_id)
  end
end
