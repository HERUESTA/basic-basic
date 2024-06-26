class Board < ApplicationRecord
  mount_uploader :board_image, AvatarUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  def bookmark_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
end
