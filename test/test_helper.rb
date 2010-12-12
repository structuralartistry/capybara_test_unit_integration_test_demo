ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
end


# for using Capybara in tests -- taken from the tartare-rails gem
require 'capybara/rails'

module ActionController

  class IntegrationTest
    include Capybara

    Capybara.register_driver :selenium do |app|
      Capybara::Driver::Selenium.new(app, :browser => :firefox)
    end

    Capybara.default_driver = :selenium
    # :selenium_chrome
    
    Capybara.ignore_hidden_elements = true 

    self.use_transactional_fixtures = false
    
    Dir.glob("test/integration/helpers/*.rb").each do |helper_file|
      # for some reason the Dir.glob starts at rails root but when requiring, it starts within test/*
      require helper_file.gsub(/test\//, '')  
    end
  end

end
