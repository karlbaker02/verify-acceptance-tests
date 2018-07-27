Feature: User submit feedback

  This tests user feedback submission with no session cookie.

  Scenario: User successfully submits feedback with no valid session
    Given the user is at Test RP
    And they start a sign in journey but their session times out
    And they go back to the start page
    Then they are shown the cookies missing page
    When they go to the feedback form
    And they enter some feedback and submit the form
    Then they receive confirmation that feedback was sent


