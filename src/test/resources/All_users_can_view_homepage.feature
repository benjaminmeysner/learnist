@19 @must @learner @lecturer @administrator @unregistered

Feature: All users can view homepage
  As a user
  I want to access homepage of the website
  So that I can see a preview of the learning platform

  Background:
    Given user is not logged in

  Scenario: Non-registered user has navigated to the site
    When the user navigates to ""
    Then the returned view is index

  Scenario: Non-registered user tries to access learner section
    When the user navigates to "/learner"
    Then the user is redirected to "/login"

  Scenario: Non-registered user tries to access lecturer section
    When the user navigates to "/lecturer"
    Then the user is redirected to "/login"
