Feature: User registers, returns to confirm identity and signs in successfully

  This tests user non-repudiation flow.

  Scenario: User registers, confirms identity and signs in
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they have all their documents
    And they have a smart phone
    And they continue to register with IDP "Stub Idp Demo Two"
    And they submit user details:
          | firstname       | Jane       |
          | surname         | Doe        |
          | addressLine1    | 123        |
          | addressLine2    | Test Drive |
          | addressTown     | Marlbury   |
          | addressPostCode | ABC 123    |
          | dateOfBirth     | 1987-03-03 |
    Then our Consent page should show "Level of assurance" = "LEVEL_2"
    When they give their consent
    Then they should be successfully verified
    When they click "Confirm Identity"
    Then they arrive at the confirm identity page for "Stub Idp Demo Two"
    When they click "Sign in with Stub Idp Demo Two"
    And they login as the newly registered user
    Then they should be successfully verified
