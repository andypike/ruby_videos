module Presenters
  class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
