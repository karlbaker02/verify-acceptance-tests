require 'yaml'
require 'uri'
require 'securerandom'

TEST_ENV = ENV.fetch('TEST_ENV', 'local')
ENVIRONMENTS = YAML.load_file(File.join(__dir__, 'environments.yml'))

def env(key)
  ENVIRONMENTS.dig(TEST_ENV, key)
end

def eidas_enabled?
  @eidasEnabled.nil? ? true : @eidasEnabled
end

Given("the user is at Test RP") do
  visit(env('test-rp'))
end

Given("we do not want to match the user") do
  check('no-match')
end

Given("we want to fail account creation") do
  check('fail-account-creation')
end

Given("we set the RP name to {string}") do |name|
  fill_in('rp-name', with: name)
  @eidasEnabled = (name != 'test-rp-non-eidas')
end

Given("they start a journey") do
  click_on('Start')
end

Given("they start a sign in journey") do
  click_on('Start')
  click_on('Use GOV.UK Verify') if eidas_enabled?
  choose('start_form_selection_false')
  click_on('Continue')
end

Given("they start a registration journey") do
  click_on('Start')

  click_on('Use GOV.UK Verify') if eidas_enabled?
  choose('start_form_selection_true')
  click_on('Continue')
  click_on('Next')
  click_on('Next')
  click_on('Start now')
  click_on('Continue')

  choose('will_it_work_for_me_form_above_age_threshold_true')
  choose('will_it_work_for_me_form_resident_last_12_months_true')
  click_on('Continue')
end

Given("they start an eIDAS journey") do
  click_on('Start')
  click_on('Select your European digital identity')
end

When("they choose to use Verify") do
  click_on('Use GOV.UK Verify')
end

When("they choose to use a European identity scheme") do
  click_on("Select your European digital identity")
end

Given("they select country {string}") do |string|
  select(string, from: 'country')
  click_on('Select')
end

Given("they register with country {string}") do |string|
  select(string, from: 'country')
  click_on('Select')
  click_on('Register')
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

Given("they login as {string} with a random pid") do |username|
  fill_in('username', with: username)
  fill_in('password', with: 'bar')
  click_on('SignIn')
  assert_text("You've successfully authenticated")
  page.execute_script('document.getElementById("randomPid").value = "true"')
  click_on('I Agree')
end

Given("they submit cycle 3 {string}") do |string|
  fill_in('cycle_three_attribute[cycle_three_data]', with: string)
  click_on('Continue')
end

Given("they have all their documents") do
  choose('select_documents_form_any_driving_licence_true')
  choose('Great Britain')
  choose('select_documents_form_passport_true')
  click_on('Continue')
end

Given("they have a smart phone") do
  choose('select_phone_form_mobile_phone_true')
  choose('select_phone_form_smart_phone_true')
  click_on('Continue')
end

Given("they do not have a phone") do
  choose('select_phone_form_mobile_phone_false')
  click_on('Continue')
end

Given("they register with {string}") do |idp|
  click_on("Choose #{idp}")
  click_on("Continue to the #{idp} website")
end

Given("they select IDP {string}") do |idp|
  click_on("Select #{idp}", match: :first)
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

Given("they enter eidas user details:") do |details|
  details.rows_hash.each do |input, value|
    fill_in(input, with: value)
  end

  fill_in('username', with: SecureRandom.hex)
  fill_in('password', with: 'bar')
  click_on('Register')
  click_on('I Agree')

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

Then("user account creation should fail") do
  assert_text("Sorry, something went wrong")
end

Then('they arrive at the Start page') do
  assert_text('Sign in with GOV.UK Verify')
end

Then('they arrive at the country picker') do
  assert_text('Which EU country is your eID from?')
end
