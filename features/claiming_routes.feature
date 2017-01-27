Feature: The user can use their turn to claim a route.
  Scenario: The user uses their turn to claim a route and the route appears as claimed.
    Given a game with 5 players is setup
    And the user is on the game page
    And the player has 5 train pieces
    And the payer has 5 "Grey" train cars
    When the user claims a route from "Vancouver" to "Calgary"
    And the user selects 5 "Grey" train cars
    And the user clicks the "Claim Route" button
    Then the user is on the game page
    And the user sees the route from "Vancouver" to "Calgary" claimed with their name

  Scenario: The user uses their turn to claim a route but sees that they do not have enough train pieces.
    Given a game with 5 players is setup
    And the user is on the game page
    And the user has 0 train pieces
    When the user claims a route from "Vancouver" to "Calgary"
    And the user selects 5 "Grey" train cars
    And the user clicks the "Claim Route" button
    Then the user is on the game page
    And the user sees an error that they do not have enough pieces to claim the route
