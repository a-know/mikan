CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ONLY_S3'],
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY_ONLY_S3'],
      :region                 => 'ap-northeast-1',
      :path_style             => true,
  }

  config.fog_public     = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  case Rails.env
    when 'production'
      config.fog_directory = 'prod.mikanz.net'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/prod.mikanz.net'
    when 'staging'
      config.fog_directory = 'stg.mikanz.net'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/stg.mikanz.net'
    when 'development'
      config.fog_directory = 'dev.mikanz.net'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dev.mikanz.net'
    when 'test'
      config.fog_directory = 'dev.mikanz.net'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dev.mikanz.net'
  end
end
