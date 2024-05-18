class AvatarUploader < CarrierWave::Uploader::Base
  # This is a sensible default for uploaders that are meant to be mounted:
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロードした画像の表示
  def default_url
    'board_placeholder.png'
  end

  # デフォルト画像の設定
  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
