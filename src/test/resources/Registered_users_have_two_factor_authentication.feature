@23 @must

Feature: Registered users have two-factor authentication
  As a registered user
  I want a two-factor authentication
  So that my account is more secure

  Background:
    Given an activated learner with username "learner", email "learner@example.com" and password "test1234"
    And an activated lecturer with username "lecturer", email "lecturer@example.com", password "test1234", firstname "Man" and surname "McManson"
    And an activated administrator with username "administrator", email "administrator@example.com", password "test1234" and access level "0"

  @learner @lecturer @administrator
  Scenario: User submits incorrect authentication digits
    Given the user enters the key "1234567"
    When the user clicks the 2FA submit button
    Then the user will not be logged in
    And the session will have an error message saying "Invalid Key: 1234567".

  Scenario Outline: User submits correct authentication digits
    Given "<username>" enters the correct key
    When the user clicks the 2FA submit button
    Then the user will be logged in
    And the user is redirected to "<url>"

    #the first /learner means the controller while the 2nd /learner
    #stands for the actual user name

  @learner
    Examples:
      | username | url           |
      | learner  | /user/learner |

  @lecturer
    Examples:
      | username | url            |
      | lecturer | /user/lecturer |

  @administrator
    Examples:
      | username      | url            |
      | administrator | /administrator |