Feature: Rep Testing

Scenario: representative search functionality
  Given I am on the representatives page
  Then I should see "Search for a Representative"
  When I fill in "address" with "Washington"
  When I press "Search"
  Then I should see "Susan Owens"