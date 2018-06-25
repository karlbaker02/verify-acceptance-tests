Feature: eIDAS user journeys

  This tests eIDAS end-to-end journeys in the Verify Hub via the Rails frontend.

  Scenario: User selects a country and then goes back to select another
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"
    Given they go back to the country picker
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"

  Scenario: User signs in with a country
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country"
    Then they should be successfully verified


  Scenario: User with accents in name signs in
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country-accents"
    Then they should be successfully verified


  Scenario: User with non-Latin name signs in
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country-nonlatin"
    Then they should be successfully verified


  Scenario: User signs in with a country and does Cycle 3
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country-ec3"
    And they submit cycle 3 "AA123456A"
    Then they should be successfully verified


  Scenario: User registers with stub country, with cycle3 and forces UAC
    Given the user is at Test RP
    And we do not want to match the user
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they click Register
    And they enter eidas user details:
      | firstname   | Bob        |
      | surname     | Doe        |
      | dateOfBirth | 1987-03-03 |
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Bob        |
      | surname     | Doe        |
      | dateofbirth | 1987-03-03 |


  Scenario: User signs creates a new account
    Given the user is at Test RP
    And we do not want to match the user
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country"
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Jack       |
      | surname     | Bauer      |
      | dateofbirth | 1984-02-29 |
