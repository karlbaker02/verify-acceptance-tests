Feature: User account creation

  This tests user account creation flows.

  @javascript
  Scenario: Account creation for registering user
    Given the user is at Test RP
    And we do not want to match the user
    And they start a journey
    And they register with "Experian" as "Jane Doe"
    And they submit cycle 3 "AA123456A"
    Then the user "Jane Doe" should have been created
