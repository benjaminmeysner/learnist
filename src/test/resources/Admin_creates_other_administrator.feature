@27 @must @administrator

Feature: Administrator can create other administrators.
  As an administrator
  I want to create a new account for an administrator
  So that there can be more than one administrator

  Background:
    Given an activated administrator with username "administrator", email "administrator@example.com", password "test1234" and access level "0"
    And an activated administrator with username "administrator2", email "administrator2@example.com", password "test1234" and access level "2"
    And "administrator" is logged in.

  Scenario: Admin successfully creates an administrator account.
    Given a user with username "admin2", email "admin2@example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there is an account with the username "admin2" and email "admin2@example.com" in the db.
    And the user's account is not activated

  Scenario: Admin has too low an access level
    Given "administrator2" is logged in.
    And a user with username "admin2", email "admin2@example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.
    And the user will receive an error message "registerError", saying "Your access level too low!".

  Scenario: User leaves username empty
    Given a user with username "", email "admin2@example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Username is too long
    Given a user with username "abcdefghijklmnopq", email "admin2@example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Username is too short
    Given a user with username "admin", email "admin2@example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Username already exists
    Given a registered learner with username "admin2", email "admin2@example.com" and password "test1234"
    And a user with username "admin2", email "newadmin2@example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 3 accounts in the db.

  Scenario: Email empty
    Given a user with username "admin2", email "" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Email invalid
    Given a user with username "admin2", email "admin2example.com" and password "test1234".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Email exists
    Given a registered learner with username "admin2", email "admin2@example.com" and password "test1234"
    And an access level of "2".
    Given a user with username "newadmin2", email "admin2@example.com" and password "test1234".
    When the user clicks the add administrator submit button.
    Then there are 3 accounts in the db.

  Scenario: Password empty
    Given a user with username "admin2", email "admin2@example.com" and password "".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Password is too short
    Given a user with username "admin2", email "admin2@example.com" and password "test".
    And an access level of "2".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Access level empty
    Given a user with username "admin2", email "admin2@example.com" and password "test1234".
    And an access level of "".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.

  Scenario: Access level too low
    Given a user with username "admin2", email "admin2@example.com" and password "test1234".
    And an access level of "-1".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.
    And the user will receive an error message "registerError", saying "Invalid Access Level!".

  Scenario: Access level too high
    Given a user with username "admin2", email "admin2@example.com" and password "test1234".
    And an access level of "3".
    When the user clicks the add administrator submit button.
    Then there are 2 accounts in the db.
    And the user will receive an error message "registerError", saying "Invalid Access Level!".