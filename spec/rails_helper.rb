# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
require 'devise'
require 'factory_bot'
require 'bot_helper'
ENV['RAILS_ENV'] ||= 'test'

SimpleCov.start "rails" do
  add_filter "app/channels/application_cable/channel.rb"
  add_filter "app/channels/application_cable/connection.rb"
  add_filter "app/controllers/user/omniauth_callbacks_controller.rb"
  add_filter "app/jobs/application_job.rb"
  add_filter "app/mailers/application_mailer.rb"
  add_filter "app/controllers/user/registrations_controller.rb"
end

require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature
  # config.extend ControllerMacros, :type => :controller
end