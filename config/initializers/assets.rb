# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( select2.css )

# Configure jsbundling-rails and cssbundling-rails to use npm
Rails.application.config.after_initialize do
  ENV["JSBUNDLING_PACKAGE_MANAGER"] = "npm"
  ENV["CSSBUNDLING_PACKAGE_MANAGER"] = "npm"
  
  # Force npm for cssbundling-rails
  if defined?(CssbundlingRails)
    CssbundlingRails.configure do |config|
      config.package_manager = "npm"
    end
  end
  
  # Force npm for jsbundling-rails
  if defined?(JsbundlingRails)
    JsbundlingRails.configure do |config|
      config.package_manager = "npm"
    end
  end
end
