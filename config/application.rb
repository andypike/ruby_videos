require File.expand_path("../boot", __FILE__)

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module RubyVideos
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
    config.suggestions_email = ENV["SUGGESTIONS_EMAIL"]
  end
end
