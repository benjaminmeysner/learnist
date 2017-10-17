
@24 @must

Feature: Registered users can request deletion of account
  As a registered user
  I want to be able to request my account to be deleted
  So that my account no longer exists

  Background:
    Given a registered learner with username "learner", email "learner@example.com" and password "test1234"

 Scenario: learner chooses not to deactivate account
    Given learner with username "learner"
    When the learner clicks the delete account button
    And the learner clicks the No button
    Then the learner's account is not deleted


   Scenario: learner chooses to deactivate account
    Given learner with username "learner"
    When the learner clicks the delete account button
    And the learner clicks the Yes button
    Then an email is sent to "Administrator"
