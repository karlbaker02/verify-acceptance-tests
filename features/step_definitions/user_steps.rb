require 'yaml'
require 'uri'
require 'securerandom'

TEST_ENV = ENV.fetch('TEST_ENV', 'local')
ENVIRONMENTS = YAML.load_file(File.join(__dir__, 'environments.yml'))

def env(key)
  ENVIRONMENTS.dig(TEST_ENV, key)
end

Given("the user is at Test RP") do
  visit(env('test-rp'))
end

Given("they start a registration journey") do
  click_on('Start')

  choose('This is my first time using Verify')
  click_on('Continue')
  click_on('Next')
  click_on('Next')
  click_on('Start now')
  click_on('Continue')
end

Given("they start an eIDAS journey") do
  click_on('Start with your European eID')
end

Given("they select country {string}") do |string|
  select(string, from: 'country')
  click_on('Select')
end

Given("they go back to the country picker") do
  visit(URI.join(env('frontend'), 'choose-a-country'))
end

Given("they login as {string}") do |username|
  fill_in('username', with: username)
  fill_in('password', with: 'bar')
  click_on('SignIn')
  click_on('I Agree')
end

Given("they submit cycle 3 {string}") do |string|
  fill_in('cycle_three_attribute[cycle_three_data]', with: string)
  click_on('Continue')
end

Given("we do not want to match the user") do
  check('no-match')
end

Given("they have all their documents") do
  choose('will_it_work_for_me_form_above_age_threshold_true')
  choose('will_it_work_for_me_form_resident_last_12_months_true')
  click_on('Continue')

  choose('select_documents_form_any_driving_licence_true')
  choose('Great Britain')
  choose('select_documents_form_passport_true')
  click_on('Continue')

  choose('select_phone_form_mobile_phone_true')
  choose('select_phone_form_smart_phone_true')
  click_on('Continue')
end

Given("they register with {string}") do |idp|
  click_on("Choose #{idp}")
  click_on("Continue to the #{idp} website")
end

Given("they enter user details:") do |details|
  details.rows_hash.each do |input, value|
    fill_in(input, with: value)
  end

  fill_in('username', with: SecureRandom.hex)
  fill_in('password', with: 'bar')
  click_on('Register')
  click_on('I Agree')

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

Then("a user should have been created with details:") do |details|
  assert_text('Your user account has been created')

  details.rows_hash.each do |k, v|
    assert_text("#{k}:#{v}")
  end
end
