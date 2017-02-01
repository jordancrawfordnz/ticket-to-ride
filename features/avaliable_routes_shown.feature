Feature: A player can see available routes between cities.
  Scenario: On a new game, a player can see all their avaliable routes.
    Given a game with 5 players is setup
    And the player navigates to the game page
    Then the player sees the destinations from each city listed
