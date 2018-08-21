Feature: User authentication failure

  This tests authentication failure flows

  Scenario: IDP returns authn failure when user attempts to register
    Given the user is at Test RP
    When they start a journey
    And this is their first time using Verify
    And they are below the age threshold
    And they choose try to verify
    Then they should arrive at the Select documents page

    When they have all their documents
    And they have a smart phone
    And they continue to register with IDP "Stub Idp Demo Two"
    When the IDP returns an Authn Failure response
    Then they should arrive at the Failed registration page

    When they choose to verify with another certified company
    And they select the link find another company to verify you
    Then they should arrive at the Select documents page


  Scenario: IDP returns authn failure when user Signs in
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they fail sign in with idp
    Then they should arrive at the Failed sign in page

    When they choose to start again with another IDP
    Then they should arrive at the Start page


  Scenario: IDP returns authn failure requester error when user Signs in
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When the IDP returns a Requester Error response
    Then they should arrive at the Failed sign in page

    When they choose to start again with another IDP
    Then they should arrive at the Start page