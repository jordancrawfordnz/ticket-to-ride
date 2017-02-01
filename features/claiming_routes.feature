Feature: A player can use their turn to claim a route.
  Scenario: Claiming a route sends the player to the claim route page.
    Given a game with 5 players is setup
    And the player has 5 train pieces
    And the player has 5 "Hopper" train cars
    And the player navigates to the game page
    When the player clicks the claim route button on a route between "Vancouver" and "Calgary"
    Then the player is on the claim route page
    And the player sees a list of their train cars on the claim route page
    And the player sees the text "Between Vancouver and Calgary"
    And the player sees the text "Colour: Gray"
    And the player sees the text "Pieces: 3"

  Scenario: The player uses their turn to claim a route and the route appears as claimed.
    Given a game with 5 players is setup
    And the player has 5 train pieces
    And the player has 5 "Hopper" train cars
    And the player navigates to the game page
    When the player clicks the claim route button on a route between "Vancouver" and "Calgary"
    And the player selects 5 "Hopper" train cars
    And the player clicks the "Claim Route" button
    Then the player is on the game page
    And the player sees the route from "Vancouver" to "Calgary" claimed with their name

  Scenario: The player uses their turn to claim a route but sees that they do not have enough train pieces.
    Given a game with 5 players is setup
    And the player has 0 train pieces
    And the player selects 5 "Hopper" train cars
    And the player navigates to the game page
    When the player clicks the claim route button on a route between "Vancouver" and "Calgary"
    And the player clicks the "Claim Route" button
    Then the player is on the game page
    And the player sees an error that they do not have enough pieces to claim the route
