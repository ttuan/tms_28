class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    Settings.image_type
  end
end
