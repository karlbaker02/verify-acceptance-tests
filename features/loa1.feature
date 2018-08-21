Feature: User loa1

  This tests user loa1 flows.

  Scenario: Registration successful with IDP
    Given the user is at Test RP
    And we set the RP name to "loa1-test-rp"
    When they start a journey
    And they choose an loa1 registration journey
    And they register for an LOA1 profile with IDP "Stub Idp Demo One"
    When they submit loa1 user details:
      | firstname       | Jessica    |
      | surname         | Rabbit     |
      | addressLine1    | 1 Two St   |
      | addressLine2    | Wells      |
      | addressTown     | newtown    |
      | addressPostCode | 1A 2BC     |
      | dateOfBirth     | 1960-03-23 |
    Then our Consent page should show "Level of assurance" = "LEVEL_1"
    When they give their consent
    Then they should be successfully verified


  Scenario: Sign in successful with IDP
    Given the user is at Test RP
    And we set the RP name to "loa1-test-rp"
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one-loa1"
    Then they should be successfully verified