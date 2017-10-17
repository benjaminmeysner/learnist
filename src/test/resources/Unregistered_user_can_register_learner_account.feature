@20 @must @unregistered @learner

Feature: Unregistered user can register for a learner account
  As an unregistered user
  I want to register for a learner account
  So that I have access to the learning platform

  Background:
    Given there are no users.

  Scenario: User successfully registers for a learner's account
    Given a user with username "learner", email "learner@example.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then there is an account with the username "learner" and email "learner@example.com" in the db.
    And the returned view is register/success
    And the user's account is not activated

  Scenario: User leaves username empty
    Given a user with username "", email "learner@example.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.

  Scenario: Username is too long
    Given a user with username "abcdefghijklmnopq", email "learner@example.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.

  Scenario: Username is too short
    Given a user with username "learn", email "learner@example.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.

  Scenario: Username already exists
    Given a registered learner with username "learner", email "learner@example.com" and password "test1234"
    Given a user with username "learner", email "newlearner@example.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there is 1 account in the db.

  Scenario: Email empty
    Given a user with username "learner", email "" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.

  Scenario: Email invalid
    Given a user with username "learner", email "learnerexample.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.

  Scenario: Email exists
    Given a registered learner with username "learner", email "learner@example.com" and password "test1234"
    Given a user with username "newlearner", email "learner@example.com" and password "test1234".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there is 1 account in the db.

  Scenario: Password empty
    Given a user with username "learner", email "learner@example.com" and password "".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.

  Scenario: Password is too short
    Given a user with username "learner", email "learner@example.com" and password "test".
    When the user clicks the register "learner" submit button
    Then the returned view is register/learner
    And there are 0 accounts in the db.