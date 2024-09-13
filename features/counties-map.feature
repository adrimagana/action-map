Feature: Representative profile test

  As a user
  I want to see only representatives from my county

Background: Representatives in my county

  Given the following representatives exist:
  | name                        | divisionId                        |office|
  | Joseph R. Biden             | ocd-division/country:us           | President of the United States|
  | Kamala D. Harris            | ocd-division/country:us           | Vice President of the United States|
  | Alex Padilla                | ocd-division/country:us/state:ca  | U.S. Senator|

Scenario: Show representatives from California
  Given I am on the home page
  When I navigate to the Los Angeles County in California
  Then I should see the representatives: "Joseph R. Biden","Kamala D. Harris","Alex Padilla"
