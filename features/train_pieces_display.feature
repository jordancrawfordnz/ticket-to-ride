Feature: The user can see their remaining train pieces
  Scenario: The user is given 45 train pieces initially
    Given a game with 5 players is setup
    And the user is on the game page
    Then the user sees they have 45 train pieces
