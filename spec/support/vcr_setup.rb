VCR.configure do |config|
  # https://coderwall.com/p/absicw/recipe-using-vcr-for-specs
  # where the cassettes will be saved
  config.cassette_library_dir = "spec/cassettes"
  # HTTP request service
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = true
  config.default_cassette_options = { record: :new_episodes }
  config.filter_sensitive_data("<STRIPE_API_KEY>") { ENV["STRIPE_API_KEY"] }
end
