Feature: A player can see their train cards
  Scenario: The player is given three train cards initially
    Given a game with 5 players is setup
    And the player is on the game page
    Then the player sees 4 train cars
