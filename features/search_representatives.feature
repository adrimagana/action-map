Feature: Map tests

Scenario: National Map
  Given I am on the home page 
  Then I should see "National Map"

Scenario: State Page
  Given a state is selected
  Given I am on the state page
  Then I should see "California"
  When I press "Counties in California"
  Then I should see "Almeda County"