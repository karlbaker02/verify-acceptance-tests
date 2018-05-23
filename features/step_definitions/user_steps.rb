require 'yaml'
require 'uri'

TEST_ENV = ENV.fetch('TEST_ENV', 'local')
ENVIRONMENTS = YAML.load_file(File.join(__dir__, 'environments.yml'))

def env(key)
  ENVIRONMENTS.dig(TEST_ENV, key)
end

Given("the user is at the country picker") do
  visit(env('test-rp'))
  click_on('Start with your European eID')
end

Given("they select country {string}") do |string|
  select(string, from: 'country')
  click_on('Select')
end

Given("they go back to the country picker") do
  visit(URI.join(env('frontend'), 'choose-a-country'))
end

Given("they login as user {string} with password {string}") do |username, password|
  fill_in('username', with: username)
  fill_in('password', with: password)
  click_on('SignIn')
end

Given("they consent") do
  click_on('I Agree')
end

When("they submit cycle 3 {string}") do |string|
  fill_in('cycle_three_attribute[cycle_three_data]', with: string)
  click_on('Continue')
end

Then("they should be at IDP {string}") do |idp|
  page = env('idps').fetch(idp)
  assert_current_path(page, url: true)
end

Then("they should be successfully verified") do
  find('.success-notice')
  assert_text('Your identity has been confirmed')
end
