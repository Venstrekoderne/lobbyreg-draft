Rails.application.config.sorcery.submodules = []
Rails.application.config.sorcery.configure do |config|
  config.user_class = "AllowedSyncer"
end
