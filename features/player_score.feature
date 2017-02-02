Feature: A player has a score which changes when they claim a route
  Scenario: The user can see their initial score of 0 upon starting a game
    Given a game with 5 players is setup
    And the player navigates to the game page
    Then the player sees their score on the page
