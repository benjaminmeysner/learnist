@30 @must @administrator

Feature: Administrators can deactivate accounts
  As an administrator
  I can deactivate learner and lecturer accounts
  So the user can't use the account whilst under investigation

  Background:
    Given an activated learner with username "learner", email "learner@example.com" and password "test1234"
    And an activated lecturer with username "lecturer", email "lecturer@example.com", password "test1234", firstname "Man" and surname "McManson"
    And an activated administrator with username "administrator", email "administrator@example.com", password "test1234" and access level "0"
    And "administrator" is logged in.

  Scenario: Admin deactivates learner account
    Given "learner"'s account is being viewed.
    And the user's account is set to deactivated.
    When the administrator clicks the user edit submit button.
    And "learner"'s account is not activated.

  Scenario: Admin deactivates lecturer account
    Given "lecturer"'s account is being viewed.
    And the user's account is set to deactivated.
    When the administrator clicks the user edit submit button.
    And "lecturer"'s account is not activated.

  Scenario: Admin can't deactivate an account of type Administrator
    Given "administrator"'s account is being viewed.
    And the user's account is set to deactivated.
    When the administrator clicks the user edit submit button.
    And "administrator"'s account is activated.
