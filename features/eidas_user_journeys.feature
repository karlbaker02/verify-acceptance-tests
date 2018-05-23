Feature: eIDAS user journeys

  This tests eIDAS end-to-end journeys in the Verify Hub via the Rails frontend.

  @javascript
  Scenario: User selects a country and then goes back to select another
    Given the user is at the country picker
    And they select country "Stub Country"
    And they go back to the country picker
    And they select country "Stub Country"
    Then they should be at IDP "Stub Country"

  @javascript
  Scenario: User signs in with a country
    Given the user is at the country picker
    And they select country "Stub Country"
    And they login as user "stub-country" with password "bar"
    And they consent
    Then they should be successfully verified

  @javascript
  Scenario: User signs in with a country and does Cycle 3
    Given the user is at the country picker
    And they select country "Stub Country"
    And they login as user "stub-country-c3" with password "bar"
    And they consent
    When they submit cycle 3 "AA123456A"
    Then they should be successfully verified
