class AddUniqueIndexToBookmarks < ActiveRecord::Migration[7.0]
  def change
    add_index :bookmarks, [:user_id, :board_id], unique: true
  end
end
