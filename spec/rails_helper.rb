ENV["RAILS_ENV"] ||= "test"

require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rails"
require "capybara/rspec"
require "sucker_punch/testing/inline"

require "support/page_objects/page_object"
require "support/page_objects/page_object_with_form"
require "support/page_objects/page_object_helpers"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.configure do |config|
  config.match = :prefer_exact
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.disable_monkey_patching!
  config.infer_base_class_for_anonymous_controllers = false
  config.backtrace_exclusion_patterns << /gems/
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.include PageObjects, :type => :feature
  config.include PageObjectHelpers, :type => :feature
  config.include MailHelpers
  config.include Rails.application.routes.url_helpers
end
