Feature: Page to pick between Verify and eIDAS journies

  Test that a page appears to allow the user to select between
  Verify and eIDAS when there is no journey hint supplied and
  the service has eIDAS enabled.


  Scenario: Verify button on picker page goes to Start page
    Given the user is at Test RP
    When they start a journey
    And they choose to use Verify
    Then they arrive at the Start page


  Scenario: eIDAS button on picker page goes to country picker
    Given the user is at Test RP
    When they start a journey
    And they choose to use a European identity scheme
    Then they arrive at the country picker


  Scenario: RP without eIDAS enabled doesn't trigger picker
    Given the user is at Test RP
    And we set the RP name to "test-rp-non-eidas"
    When they start a journey
    Then they arrive at the Start page
