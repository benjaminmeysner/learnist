@22 @must

Feature: All account types can login
  As a user
  I want to be able to login
  So I can access my account and content associated with it

  Background:
    Given a registered learner with username "learner", email "learner@example.com" and password "test1234"
    Given a registered lecturer with username "lecturer", email "lecturer@example.com", password "test1234", firstname "Man" and surname "McManson"

  @learner @lecturer @administrator
  Scenario: User does not enter any details
    Given the user enters a username "" and password ""
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "Please enter a username or email address.".

  @learner @lecturer @administrator
  Scenario: User enters an incorrect username
    Given the user enters a username "nottester" and password "test"
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "That combination didn't work, please try again!".


  @learner @lecturer @administrator
  Scenario: User enters an incorrect email
    Given the user enters a username "nottester@example.com" and password "test"
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "That combination didn't work, please try again!".


  @learner @lecturer @administrator
  Scenario: User enters an incorrect password
    Given the user enters a username "learner" and password "test"
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "That combination didn't work, please try again!".


  @learner @lecturer @administrator
  Scenario: User enters correct details but their account is not verified
    Given the user enters a username "learner" and password "test1234"
    And the user's account is not activated
    And the user's account is "Unverified"
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "Account not verified".

  @learner @lecturer @administrator
  Scenario: User enters correct details but their account is not authorised
    Given the user enters a username "learner" and password "test1234"
    And the user's account is not activated
    And the user's account is "Verified"
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "Account has not been authenticated yet.".

  @learner
  Scenario: Learner enters correct details and their account is activated
    Given the user enters a username "learner" and password "test1234"
    And the user's account is activated
    And the user's account is "Authorised"
    When the user clicks the login submit button
    Then the returned view is includes/login/pass

  @lecturer
  Scenario: Lecturer enters correct details and their account is authorised but not approved
    Given the user enters a username "lecturer" and password "test1234"
    And the user's account is not activated
    And the user's account is "Authorised"
    When the user clicks the login submit button
    Then the returned view is includes/login/login
    And the user will receive an error message "error", saying "Your application has not been approved, please await confirmation before attempting to log in.".

  @lecturer
  Scenario: Lecturer enters correct details and their account is activated and approved
    Given the user enters a username "lecturer" and password "test1234"
    And the user's account is activated
    And the user's account is "Approved"
    When the user clicks the login submit button
    Then the returned view is includes/login/pass

  @administrator
  Scenario: Administrator enters correct details and their account is activated
    Given a registered administrator with username "administrator", email "admin@example.com" and password "test1234"
    Given the user enters a username "administrator" and password "test1234"
    And the user's account is activated
    And the user's account is "Authorised"
    When the user clicks the login submit button
    Then the returned view is includes/login/pass
