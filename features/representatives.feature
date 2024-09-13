Feature: Representative tests

Scenario: Representatives Page
  Given I am on the representatives page
  Then I should see "Search for a Representative"
  When I fill in "address" with "California"
  When I press "Search"
  Then I should see "Kelli Evans"
  When I follow "Kelli Evans"
  Then I should see "Kelli Evans"
  Then I should see "350 McAllister"
  Then I should see "Nonpartisan"