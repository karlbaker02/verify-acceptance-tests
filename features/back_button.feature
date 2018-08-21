Feature: User Back button

  This tests back button flows

  Scenario: User selects an IDP and then goes back to select another
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they choose to go back to the "sign-in" page
    And they select IDP "Stub Idp Demo One"
    Then they should be at IDP "Stub Idp Demo One"


  Scenario: User selects sign in then goes back to select registration
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they choose to go back to the "sign-in" page
    Then they should arrive at the Sign in page

    When they choose to go back to the "start" page
    Then they should arrive at the Start page

    When they choose a registration journey
    Then they should arrive at the Select documents page