@24 @must

Feature: Registered users can reset password
  As a registered user
  I want to be able to reset my password
  So that I regain access to my account

  Background:
    Given a registered learner with username "learner", email "learner@example.com" and password "test1234"

  @learner @lecturer @administrator
  Scenario: User doesn't enter a password.
    Given the user enters a password "" and confirmation "".
    When the user clicks the password reset submit button
    Then the returned view is login/reset
    And the user's password is "test1234".

  @learner @lecturer @administrator
  Scenario: User doesn't enter a password confirmation
    Given the user enters a password "test4321" and confirmation "".
    When the user clicks the password reset submit button
    Then the returned view is login/reset
    And the user's password is "test1234".

  @learner @lecturer @administrator
  Scenario: User's password confirmation doesn't match
    Given the user enters a password "test4321" and confirmation "test1234".
    When the user clicks the password reset submit button
    Then the returned view is login/reset
    And the user's password is "test1234".

  @learner @lecturer @administrator
  Scenario: User enters short password
    Given the user enters a password "test1" and confirmation "test1".
    When the user clicks the password reset submit button
    Then the returned view is login/reset
    And the user's password is "test1234".

  @learner @lecturer @administrator
  Scenario: User's password and confirmation matches and the password is valid
    Given the user enters a password "test4321" and confirmation "test4321".
    When the user clicks the password reset submit button
    Then the returned view is register/success
    And the user's password is "test4321".