
Feature: Journey hint takes user to correct page

  Test that when a journey hint is supplied the user is taken 
  to the appropriate page.

Scenario: Journey hint Registration
    Given the user is at Test RP
    And they select journey hint "Registration"
    And they start a journey
    Then they arrive at the about page

  Scenario: Journey hint Sign-in with Verify
    Given the user is at Test RP
    And they select journey hint "Sign-in with Verify"
    And they start a journey
    Then they arrive at the IdP picker

  @Eidas
  Scenario: Journey hint Sign-in with eIDAS
    Given the user is at Test RP
    And they select journey hint "Sign-in with eIDAS"
    And they start a journey
    Then they arrive at the country picker

  Scenario: Journey hint Sign-in with eIDAS when Eidas is Disabled
    Given the user is at Test RP
    And we set the RP name to "test-rp-non-eidas"
    And they select journey hint "Sign-in with eIDAS"
    And they start a journey
    Then they should arrive at the Start page

  Scenario: Journey hint Non-repudiation
    Given the user is at Test RP
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    And they logout
    And they select journey hint "Non-repudiation"
    And they start a journey
    Then they arrive at the confirm identity page for "Stub Idp Demo One"

  Scenario: Journey hint Unspecified
    Given the user is at Test RP
    And they select journey hint "Unspecified"
    And they start a journey
    Then they arrive at the prove identity page

  Scenario: Journey hint Unspecified when Eidas is Disabled
    Given the user is at Test RP
    And we set the RP name to "test-rp-non-eidas"
    And they select journey hint "Unspecified"
    And they start a journey
    Then they should arrive at the Start page

