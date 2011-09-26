Feature: Admin
  In order to manage the site
  As a person in charge
  I want to be able to log in

  Scenario: Visit the admin page
    Given I am logged in as an admin
    And a lesson exists
    When I visit the dashboard
    Then I see the lesson
