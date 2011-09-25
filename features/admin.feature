Feature: Groups
  In order to manage users
  As an administrator
  I want to be able to manipulate groups

  Scenario: Add a group
    Given I visit the groups tab
    And I add a group
    When I visit the groups tab
    Then I see the group I just created

  Scenario: Add a group and add users
    Given I visit the groups tab
    And I add a group with users
    When I visit a user in that group
    Then I see she is a member of that group

  Scenario: Add a new user to an existing group
    Given There are existing groups
    And I visit the groups tab
    And I edit a group
    And I add a new user
    When I visit that user page
    Then I see she is a member of that group

