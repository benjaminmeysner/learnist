@26 @must @administrator

Feature: Administrators can accept or deny lecturer applications
  As an administrator
  I want to accept or deny lecturer account applications
  So that the user who made the application knows about their outcome

  Background:
    Given a registered lecturer with username "lecturer", email "lecturer@example.com", password "test1234", firstname "Man" and surname "McManson"
    And the user's account is "Authorised"
    And an activated administrator with username "administrator", email "administrator@example.com", password "test1234" and access level "0"
    And "administrator" is logged in.
    And "lecturer"'s application is being viewed.

  Scenario: Administrator approves application
    When the administrator clicks the accept button.
    Then "lecturer"'s status is "Approved".
    And "lecturer"'s account is activated.

  Scenario: Administrator denies application
    When the administrator clicks the deny button.
    Then "lecturer"'s status is "Authorised".
    And "lecturer"'s account is not activated.