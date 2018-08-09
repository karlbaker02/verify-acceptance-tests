Feature: User account creation

  This tests user account creation flows.

  Scenario: Registration and cycle 3
    Given the user is at Test RP
    And we do not want to match the user
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they have all their documents
    And they do not have a phone
    And they continue to register with IDP "Stub Idp Demo One"
    And they submit user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    When they give their consent
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Jane       |
      | surname     | Doe        |
      | dateofbirth | 1987-03-03 |


  Scenario: Sign in and cycle 3
    Given the user is at Test RP
    And we do not want to match the user
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Jack       |
      | surname     | Bauer      |
      | dateofbirth | 1984-02-29 |


  Scenario: Registration without cycle 3
    Given the user is at Test RP
    And we set the RP name to "test-rp-noc3"
    And we do not want to match the user
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they have all their documents
    And they do not have a phone
    And they continue to register with IDP "Stub Idp Demo One"
    And they submit user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    When they give their consent
    Then a user should have been created with details:
      | firstname   | Jane       |
      | surname     | Doe        |
      | dateofbirth | 1987-03-03 |


  Scenario: Sign in without cycle 3
    Given the user is at Test RP
    And we set the RP name to "test-rp-noc3"
    And we do not want to match the user
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then a user should have been created with details:
      | firstname   | Jack       |
      | surname     | Bauer      |
      | dateofbirth | 1984-02-29 |


  Scenario: Failed user account creation
    Given the user is at Test RP
    And we set the RP name to "test-rp-noc3"
    And we do not want to match the user
    And we want to fail account creation
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one" with a random pid
    Then user account creation should fail
