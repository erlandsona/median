# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  process :resize_to_limit => [800, 400]


end
