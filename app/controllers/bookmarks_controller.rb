class BookmarksController < ApplicationController
  skip_before_action :require_login

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def show
    render :index
  end

  def create
    @bookmark = current_user.bookmarks.build(board_id: params[:board_id])
    @bookmark.save!
    redirect_to boards_path, flash: { success: 'ブックマークしました' }
  end

  def destroy
    current_user.bookmarks.find_by(board_id: params[:id]).destroy!
    redirect_to boards_path, flash: { success: 'ブックマークを外しました' }, status: :see_other
  end

  def bookmark_params
    params.require(:bookmark).permit(:board_id)
  end
end
