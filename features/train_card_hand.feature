Feature: The user can see their train cards
  Scenario: The user is given three train cards initially
    Given a game with 5 players is setup
    And the user is on the game page
    Then the user sees 3 train cars
