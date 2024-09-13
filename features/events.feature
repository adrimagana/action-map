Feature: Event tests

Scenario: add event
  Given I am on the events page
  Then I should see "Events"
  When I go to the add events page
  Then I should see "Sign In"
  When I go to the login page
  When I press "Sign in with Google"
  When I go to the add events page
  Then I should see "New event"
  When I press "commit"
  Then I should see "County must exist"