@smoke
Feature: Holiday entitlement calculator start page
  As a user
  I want to open the holiday entitlement calculator
  So that I can start a calculation

  Scenario: The holiday entitlement start page loads with the correct title
    Given I open the holiday entitlement calculator start page
    Then the page title should be "Calculate holiday entitlement - GOV.UK"
