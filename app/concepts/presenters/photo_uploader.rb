module Presenters
  class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      ActionController::Base.helpers.asset_path("no_image.jpg")
    end

    process :resize_to_fill => [400, 400]
  end
end
