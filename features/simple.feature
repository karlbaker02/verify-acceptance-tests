Feature: User simple flows - sign in and registeration

  This tests user simple flows.

  Scenario: Sign in successful with IDP and cycle 3
    Given the user is at Test RP
    And they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    And they login as "stub-idp-demo-two-c3"
    And they submit cycle 3 "AA123456A"
    Then they should be successfully verified


  Scenario: User registers with no documents
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they do not have their documents
    And they do not have other identity documents
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
    When they give their consent
    Then they should be successfully verified