Feature: The user can see avaliable routes between cities.
  Scenario: A new game shows all avaliable routes.
    Given a game with 5 players is setup
    And the user is on the game page
    Then the user sees a list of all avaliable routes between cities
