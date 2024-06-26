class CreateJoinTableBookmark < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      add_index :bookmarks, [:user_id, :board_id], unique: true
  
      t.timestamps
    end
  end
end
