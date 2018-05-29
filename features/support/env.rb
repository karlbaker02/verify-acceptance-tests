require 'capybara/cucumber'
require 'selenium/webdriver'

Capybara.configure do |cfg|
  cfg.default_max_wait_time = 20
end

Capybara.register_driver "selenium_remote_firefox".to_sym do |app|
  Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://selenium-hub:4444/wd/hub", desired_capabilities: :firefox)
end

unless ENV['SHOW_BROWSER'] == 'true'
  Capybara.javascript_driver = :selenium_remote_firefox
end
