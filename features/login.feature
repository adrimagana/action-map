Feature:

Background:

Scenario: Google Login
  Given I am on the login page
  Then I should see "Sign In"
  When I press "Sign in with Google"
  Then I should be on the home page
  Given I am on the profile page
  Then I should see "Your Profile"
  And I should see "Google"
  Given I am on the logout page
  Then I should see "You have successfully logged out."
  Then I should be on the home page

Scenario: Github Login
  Given I am on the login page
  Then I should see "Sign In"
  When I press "Sign in with GitHub"
  Then I should be on the home page
  Given I am on the profile page
  Then I should see "Your Profile"
  And I should see "Github"
  Given I am on the logout page
  Then I should see "You have successfully logged out."
  Then I should be on the home page