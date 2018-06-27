require 'yaml'
require 'uri'
require 'securerandom'

TEST_ENV = ENV.fetch('TEST_ENV', 'local')
ENVIRONMENTS = YAML.load_file(File.join(__dir__, 'environments.yml'))

def env(key)
  ENVIRONMENTS.dig(TEST_ENV, key)
end

def see_journey_picker?
  @see_journey_picker
end

def page_heading_text(page)
  case page
  when 'select-documents' then
    'Your photo identity document'
  when 'start' then
    'Sign in with GOV.UK Verify'
  when 'start' then
    'Who do you have an identity account with?'
  end
end

Given('the user is at Test RP') do
  visit(env('test-rp'))
  @see_journey_picker = true
end

Given('we do not want to match the user') do
  check('no-match')
end

Given('we want to fail account creation') do
  check('fail-account-creation')
end

Given('we set the RP name to {string}') do |name|
  fill_in('rp-name', with: name)
  @see_journey_picker = false
end

Given('they select journey hint {string}') do |hint|
  select(hint, from: 'journey_hint')
end

Given('they start a journey') do
  click_on('Start')
end

Given('they start a sign in journey') do
  click_on('Start')
  click_on('Use GOV.UK Verify') if see_journey_picker?
  choose('start_form_selection_false')
  click_on('Continue')
end

Given('this is their first time using Verify') do
  click_on('Use GOV.UK Verify') if see_journey_picker?
  choose('start_form_selection_true')
  click_on('Continue')
  click_on('Next')
  click_on('Next')
  click_on('Start now')
  click_on('Continue')
end

Given('they choose a registration journey') do
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

Given('they choose an loa1 registration journey') do
  choose('start_form_selection_true')
  click_on('Continue')
  click_on('Next')
  click_on('Next')
  click_on('Start now')
end

And('they are above the age threshold') do
  choose('will_it_work_for_me_form_above_age_threshold_true')
  choose('will_it_work_for_me_form_resident_last_12_months_true')
  click_on('Continue')
end

And('they are below the age threshold') do
  choose('will_it_work_for_me_form_above_age_threshold_false')
  choose('will_it_work_for_me_form_resident_last_12_months_true')
  click_on('Continue')
end

Given('they start an eIDAS journey') do
  click_on('Start')
  click_on('Select your European digital identity')
end

When('they choose to use Verify') do
  click_on('Use GOV.UK Verify')
end

When('they choose to use a European identity scheme') do
  click_on('Select your European digital identity')
end

Given('they select eIDAS scheme {string}') do |scheme|
  click_on('Select ' + scheme)
end

Given('they click Register') do
  click_on('Register')
end

Given('they go back to the country picker') do
  visit(URI.join(env('frontend'), 'choose-a-country'))
  assert_text('Use a digital identity from another European country')
end

Given('they login as {string}') do |username|
  fill_in('username', with: username)
  fill_in('password', with: 'bar')
  click_on('SignIn')
  click_on('I Agree')
end

Given('they login as {string} with a random pid') do |username|
  fill_in('username', with: username)
  fill_in('password', with: 'bar')
  click_on('SignIn')
  assert_text("You've successfully authenticated")
  page.execute_script('document.getElementById("randomPid").value = "true"')
  click_on('I Agree')
end

Given('they submit cycle 3 {string}') do |string|
  fill_in('cycle_three_attribute[cycle_three_data]', with: string)
  click_on('Continue')
end

Given('they have all their documents') do
  choose('select_documents_form_any_driving_licence_true')
  choose('Great Britain')
  choose('select_documents_form_passport_true')
  click_on('Continue')
end

Given('they have a smart phone') do
  choose('select_phone_form_mobile_phone_true')
  choose('select_phone_form_smart_phone_true')
  click_on('Continue')
end

Given('they do not have a phone') do
  choose('select_phone_form_mobile_phone_false')
  click_on('Continue')
end

Given('they continue to register with IDP {string}') do |idp|
  click_on("Choose #{idp}")
  click_on("Continue to the #{idp} website")
end

Given('they register for an LOA1 profile with IDP {string}') do |idp|
  click_on("Choose #{idp}")
  assert_text('Create your ' + idp + ' identity account')
  click_on("Continue to the #{idp} website")
end

Given('they select IDP {string}') do |idp|
  click_on("Select #{idp}", match: :first)
end

Given('the IDP returns an Authn Failure response') do
  click_on('tab-login')
  click_on('Authn Failure')
end

Given('the IDP returns a Requester Error response') do
  click_on('Submit Requester Error')
end

Given('they fail sign in with idp') do
  click_on('Authn Failure')
end

Given('they choose try to verify') do
  click_link('verify-identity-online')
end

Given('they choose to verify with another certified company') do
  find('span.summary', text: 'Try verifying with another certified company').click
end

Given('they select the link find another company to verify you') do
  click_link('Find another company to verify you')
end

Given('they choose to start again with another IDP') do
  click_on('startAgain')
end

Given('they choose to go back to the {string} page') do |page|
  visit(URI.join(env('frontend'), page))

  page_text = page_heading_text(page)
  assert_text(page_text)
end

Given('they want to cancel sign in') do
  click_on('Cancel')
end

Given('they enter user details:') do |details|
  details.rows_hash.each do |input, value|
    fill_in(input, with: value)
  end

  fill_in('username', with: SecureRandom.hex)
  fill_in('password', with: 'bar')
  click_on('Register')
  click_on('I Agree')

  click_on('Continue')
end

Given('they submit loa1 user details:') do |details|
  details.rows_hash.each do |input, value|
    fill_in(input, with: value)
  end

  fill_in('username', with: SecureRandom.hex)
  fill_in('password', with: 'bar')
  select('Level 1', from: 'loa')

  click_on('Register')
end

Given('they give their consent') do
  click_on('I Agree')

  click_on('Continue')
end

Given('they enter eidas user details:') do |details|
  details.rows_hash.each do |input, value|
    fill_in(input, with: value)
  end

  fill_in('username', with: SecureRandom.hex)
  fill_in('password', with: 'bar')
  click_on('Register')
  click_on('I Agree')
end

Then('they should be at IDP {string}') do |idp|
  page = env('idps').fetch(idp)
  assert_current_path(page, url: true)
end

Then('they should be successfully verified') do
  find('.success-notice')
  assert_text('Your identity has been confirmed')
end

Then('a user should have been created with details:') do |details|
  assert_text('Your user account has been created')

  details.rows_hash.each do |k, v|
    assert_text("#{k}:#{v}")
  end
end

Then('user account creation should fail') do
  assert_text('Sorry, something went wrong')
end

Then('they should arrive at the Start page') do
  assert_text('Sign in with GOV.UK Verify')
end

Then('they arrive at the country picker') do
  assert_text('Use a digital identity from another European country')
  assert_text('You can use a digital identity from another European country to access services on GOV.UK.')
end

Then('they arrive at the IdP picker') do
  assert_text('Who do you have an identity account with?')
end

Then('they arrive at the confirm identity page for {string}') do |idp|
  assert_text('Sign in with '+idp)
end

Then('they arrive at the prove identity page') do
  assert_text('Prove your identity to continue')
  assert_text('Choose how you want to prove your identity so you can register for an identity profile.')
end

Then('they arrive at the about page') do
  assert_text('GOV.UK Verify is a secure service built to fight the growing problem of online identity theft.')
end

Then('they logout') do
  click_on('Logout')
end

Then('they should arrive at the Select documents page') do
  assert_text('Your photo identity document')
end

Then('they should arrive at the Sign in page') do
  assert_text('Who do you have an identity account with?')
end

Then('they should arrive at the Failed registration page') do
  assert_text('was unable to verify your identity')
end

Then('they should arrive at the Failed sign in page') do
  assert_text('You may have selected the wrong company')
end

Then('our Consent page should include LEVEL_1') do
  assert_text("You've successfully authenticated")
  assert_text('LEVEL_1')
end