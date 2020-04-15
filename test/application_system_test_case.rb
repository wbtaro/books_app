# frozen_string_literal: true

require "test_helper"

if ENV["CHROME_DRIVER_PATH"]
  Selenium::WebDriver::Chrome::Service.driver_path = ENV["CHROME_DRIVER_PATH"]
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
