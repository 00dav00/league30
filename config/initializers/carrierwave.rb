CarrierWave.configure do |config|
  # For testing, upload files to local `tmp` folder.
  config.storage = :file
  config.enable_processing = !Rails.env.test?
end
