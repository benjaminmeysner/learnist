@21 @must @unregistered @lecturer

Feature: Unregistered user can register learner account
  As an unregistered user
  I want to request a lecturer account
  So that I can create a course and teach learners

  Background:
    Given there are no users.

  Scenario: User successfully requests for a lecturers account
    Given a user with username "lecturer", email "lecturer@example.com" and password "test1234".
    And firstname "Man" and surname "McManson"
    When the user clicks the register "lecturer" submit button
    Then there is an account with the username "lecturer" and email "lecturer@example.com" in the db.
    And the returned view is register/success
    And the user's account is not activated

  Scenario: First name empty
    Given a user with username "lecturer", email "lecturer@example.com" and password "test1234".
    And firstname "" and surname "McManson"
    When the user clicks the register "lecturer" submit button
    Then the returned view is register/lecturer
    And there are 0 accounts in the db.

  Scenario: Last name empty
    Given a user with username "lecturer", email "lecturer@example.com" and password "test1234".
    And firstname "Man" and surname ""
    When the user clicks the register "lecturer" submit button
    Then the returned view is register/lecturer
    And there are 0 accounts in the db.


  Scenario: First name too long
    Given a user with username "lecturer", email "lecturer@example.com" and password "test1234".
    And firstname "abcdefghijklmnopqrstuvwxyzabcde" and surname "McManson"
    When the user clicks the register "lecturer" submit button
    Then the returned view is register/lecturer
    And there are 0 accounts in the db.

  Scenario: Surname too long
    Given a user with username "lecturer", email "lecturer@example.com" and password "test1234".
    And firstname "Man" and surname "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrtuvwxyz"
    When the user clicks the register "lecturer" submit button
    Then the returned view is register/lecturer
    And there are 0 accounts in the db.

  Scenario: Username exists
    Given a registered lecturer with username "lecturer", email "lecturer@example.com", password "test1234", firstname "Man" and surname "McManson"
    And a user with username "lecturer", email "newlecturer@example.com" and password "test1234".
    And firstname "Man" and surname "McManson"
    When the user clicks the register "lecturer" submit button
    Then the returned view is register/lecturer
    And there is 1 accounts in the db.

  Scenario: Email exists
    Given a registered lecturer with username "lecturer", email "lecturer@example.com", password "test1234", firstname "Man" and surname "McManson"
    And a user with username "newlecturer", email "lecturer@example.com" and password "test1234".
    And firstname "Man" and surname "McManson"
    When the user clicks the register "lecturer" submit button
    Then the returned view is register/lecturer
    And there is 1 account in the db.

#  Scenario: Resume document size is too big
#    When user has cv.docx as resume
#    And has file size 5001KB
#    Then an error message is displayed stating that resume file size is too big

#  Scenario: Resume document format not supported
#    When user has cv.md as resume
#    Then an error message is displayed stating that the resume format is not supported
