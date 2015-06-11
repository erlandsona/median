if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
# else
#   CarrierWave.configure do |config|
#     config.fog_credentials = {
#       :provider               => 'AWS',       # required
#       :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],       # required
#       :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],       # required
#       :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
#     }
#     config.fog_directory  = 'median-development'                     # required
#   end
end
