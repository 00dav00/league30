class TeamLogoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :file

  version :thumb do
    process resize_to_fill: [200,200]
  end


  def extension_whitelist
    %w(jpg jpeg png)
  end

  def content_type_whitelist
    /image\//
  end

  def store_dir
    # binding.pry
    "#{root_dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "team_logo_#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  def root_dir
    return 'uploads/test' if Rails.env.test?
    'uploads'
  end
end
