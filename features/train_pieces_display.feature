Feature: A player can see their remaining train pieces
  Scenario: A player is given 45 train pieces initially
    Given a game with 5 players is setup
    And the player is on the game page
    Then the player sees they have 45 train pieces
