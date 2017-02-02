Feature: A user can create a new game
  Scenario: The user is taken to the game page upon creating a new game
    Given the user is on the root page
    When the user inputs details about 5 players
    And the user clicks the "Create Game" button
    Then the player is on the game page

  Scenario: The user sees an error message if they submit a player without a name
    Given the user is on the root page
    When the user fills in details about 4 players and 1 without a player name
    And the user clicks the "Create Game" button
    Then the user sees an error "Name can't be blank"
