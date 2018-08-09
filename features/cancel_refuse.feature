Feature: User cancel or refuse

  This tests user cancellation or refuse flows.

  Scenario: User cancels at Idp login
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they want to cancel sign in
    Then they should arrive at the Start page
