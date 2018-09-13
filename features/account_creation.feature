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
      | firstname      | Jane           |
      | surname        | Doe            |
      | currentaddress | 123 Test Drive |
      | dateofbirth    | 1987-03-03     |

  Scenario: Sign in and cycle 3
    Given the user is at Test RP
    And we do not want to match the user
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname      | Jack       |
      | surname        | Bauer      |
      | dateofbirth    | 1984-02-29 |
      | currentaddress | 1 Two St   |

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
      | firstname      | Jane           |
      | surname        | Doe            |
      | dateofbirth    | 1987-03-03     |
      | currentaddress | 123 Test Drive |


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
    Then should arrive at the user account creation error page
    When they click on link "Other ways to prove your identity online"
    Then they should arrive at the Test RP start page with error notice

  @Eidas
  Scenario: Failed user account creation with eIDAS and retried
    Given the user is at Test RP
    And we do not want to match the user
    And we want to fail account creation
    And they start an eIDAS journey
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"
    And they login as "stub-country-new"
    And they submit cycle 3 "AB123456C"
    Then should arrive at the user account creation error page
    When they click on link "Other ways to prove your identity online"
    Then they should arrive at the prove identity page
    And they choose to use a European identity scheme
    Then they should arrive at the country picker

  @Eidas
  Scenario: Failed user account creation with eIDAS and retried with Verify
    Given the user is at Test RP
    And we do not want to match the user
    And we want to fail account creation
    And they start an eIDAS journey
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"
    And they login as "stub-country-new"
    And they submit cycle 3 "AB123456C"
    Then should arrive at the user account creation error page
    When they click on link "Other ways to prove your identity online"
    Then they should arrive at the prove identity page
    And they choose to use Verify
    Then they should arrive at the Start page
