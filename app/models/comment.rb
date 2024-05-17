class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :body, presence: { message: 'を入力してください' }, length: { maximum: 65_535 }
end
