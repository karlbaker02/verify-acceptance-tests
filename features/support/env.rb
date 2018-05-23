require 'capybara/cucumber'

Capybara.configure do |cfg|
  cfg.default_max_wait_time = 10
end
