class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title,    null: false
      t.text :body,       null: false

      t.timestamps       null: false
    end
  end
end
