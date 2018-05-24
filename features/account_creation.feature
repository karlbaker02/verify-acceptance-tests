Feature: User account creation

  This tests user account creation flows.

  @javascript
  Scenario: Account creation for registering user
    Given the user is at Test RP
    And we do not want to match the user
    And they start a registration journey
    And they have all their documents
    And they register with "Experian"
    And they enter user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Jane       |
      | surname     | Doe        |
      | dateofbirth | 1987-03-03 |
