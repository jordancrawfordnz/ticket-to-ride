Feature: The user can use their turn to draw additional train cars
  Scenario: The user uses their turn to draw train cars and the train cars appear in their hand
    Given a game with 5 players is setup
    And the user is on the game page
    And the user sees 4 train cars
    When the user draws additional train cars
    Then the user sees 6 train cars

  Scenario: The user uses their turn to draw train cars but sees an error that there aren't enough in the deck
    Given there are 20 train cars in the deck
    And a game with 5 players is setup
    And the user is on the game page
    When the user draws additional train cars
    Then the user sees an error "Could not draw train cars."
    And the user sees 4 train cars
