@smoke
Feature: Holiday entitlement calculator start page
  As a user
  I want to open the holiday entitlement calculator
  So that I can start a calculation

  Scenario: The holiday entitlement start page loads with its title, heading and Start now button
    Given I open the holiday entitlement calculator start page
    Then the page title should be "Calculate holiday entitlement - GOV.UK"
    And the main heading should be "Calculate holiday entitlement"
    And the "Start now" button should be visible
