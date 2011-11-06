Feature: Discussions
  In order to get and recieve support
  As a user
  I want to be able to have a discussion with my course-mates

  Background:
    Given I am logged in as a user

  Scenario: Read the discussions
    Given There are some comments
    When I look at the discussions
    Then I see the comments

  Scenario: Make a comment
    Given I make a commment
    Then I should see my comment
