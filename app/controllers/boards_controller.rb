class BoardsController < ApplicationController
  before_action :require_login
  def index
    @boards = Board.all.includes(:user)
  end
end
