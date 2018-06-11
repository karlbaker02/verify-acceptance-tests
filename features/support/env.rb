require 'capybara/cucumber'
require 'selenium/webdriver'

Capybara.configure do |cfg|
  cfg.default_max_wait_time = 20
end

if ENV['TEST_ENV'] == "local" || ENV['SHOW_BROWSER']
  Capybara.register_driver :firefox_headless do |app|
    options = ::Selenium::WebDriver::Firefox::Options.new
    options.args << '--headless'

    Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
  end
  Capybara.javascript_driver = :firefox_headless unless ENV['SHOW_BROWSER'] == 'true'
else
  Capybara.register_driver "selenium_remote_firefox".to_sym do |app|
    Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://selenium-hub:4444/wd/hub", desired_capabilities: :firefox)
  end

  Capybara.javascript_driver = :selenium_remote_firefox
end
