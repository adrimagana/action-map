Feature: News Item

Background:

Scenario: Search Page -- Representation and Issue
  Given I am on the representatives page
  When I fill in "address" with "CA"
  When I press "Search"
  When I go to Listing News Articles for Gavin Newsom
  Then I should see "Sign In"
  Given I am on the login page
  When I press "Sign in with Google"
  When I go to Listing News Articles for Gavin Newsom
  Then I should see Representative and Issue dropdowns
  Then in Representative first_dropdown I should see Gavin Newsom
  Then in Representative first_dropdown I should see Rob Bonta
  Then in Representative first_dropdown I should see Kelli Evans
  Then in Representative first_dropdown I should see Tony Thurmond
  Then in Issue second_dropdown I should see Free Speech
  Then in Issue second_dropdown I should see Immigration
  Then in Issue second_dropdown I should see Terrorism
  Then in Issue second_dropdown I should see Equal Pay
  Then in Issue second_dropdown I should see Tax Reform
  Then in Issue second_dropdown I should see Racism