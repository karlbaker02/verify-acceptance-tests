require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
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

#Screenshot config

## screenshots saved under test name + date
Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do |example|
  puts "Example object: #{example.name}"
  "screenshot_#{example.name.gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
end

## dynamically register screenshot driver
Capybara::Screenshot.register_driver(Capybara.javascript_driver) do |driver, path|
  driver.browser.save_screenshot(path)
end

## default host to assist in rendering
Capybara.asset_host = 'http://localhost:3000'
## host directory for screenshot files
Capybara.save_path = "tmp/capybara"
# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run
