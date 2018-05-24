require 'capybara/cucumber'
require 'selenium/webdriver'

Capybara.configure do |cfg|
  cfg.default_max_wait_time = 20
end

Capybara.register_driver :firefox_headless do |app|
  options = ::Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

unless ENV['SHOW_BROWSER'] == 'true'
  Capybara.javascript_driver = :firefox_headless
end
