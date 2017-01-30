Feature: A player can use their turn to claim a route.
  Background:
    Given a game with 5 players is setup
    And the player is on the game page

  Scenario: The player uses their turn to claim a route and the route appears as claimed.
    Given the player has 5 train pieces
    And the player has 5 "Hopper" train cars
    When the player claims a route between "Vancouver" and "Calgary"
    And the player selects 5 "Hopper" train cars
    And the player clicks the "Claim Route" button
    Then the player is on the game page
    And the player sees the route from "Vancouver" to "Calgary" claimed with their name

  Scenario: The player uses their turn to claim a route but sees that they do not have enough train pieces.
    Given the player has 0 train pieces
    When the player claims a route between "Vancouver" and "Calgary"
    And the player selects 5 "Hopper" train cars
    And the player clicks the "Claim Route" button
    Then the player is on the game page
    And the player sees an error that they do not have enough pieces to claim the route
