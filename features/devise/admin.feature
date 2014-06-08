Feature: Admin
  Site should properly handle admin users

  Scenario: Signing in as an admin
    Given I am not signed in
    And I exist as an admin user
    And I am on the admin login page
    When I enter my credentials
    And I click `Sign In`
    Then I should be signed in as an admin user

  Scenario: Signing out as an admin
    Given I am signed in
    And I am on any page
    When I click `Sign Out`
    Then I should be signed out

  Scenario: Attempting to sign in with invalid credentials
    Given I am not signed in
    And I am on the admin login page
    When I enter invalid credentials
    And I click `Sign In`
    Then I should see an 'Invalid email or password' error message

  Scenario: Attempting to sign in with invalid credentials twice
    Given I am not signed in
    And I am on the admin login page
    When I attempt to sign in with an invalid password
    And I attempt to sign in with an invalid password again
    Then I should see a 'You have one more attempt before your account will be locked' error message

  Scenario: Attempting to sign in with invalid credentials three times
    Given I am not signed in
    And I am on the admin login page
    When I attempt to sign in with an invalid password
    And I attempt to sign in with an invalid password again
    And I attempt to sign in with an invalid password again
    Then I should see a 'Your account is locked' error message
    And I should not be able to sign in for 2 minutes
