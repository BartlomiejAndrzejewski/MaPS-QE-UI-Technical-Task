@holiday-entitlement @accessibility @regression
Feature: Holiday entitlement calculator accessibility
  As a user of assistive technology
  I want the calculator pages to pass automated WCAG 2.2 AA checks
  So that I can use the calculator

  Scenario: The start page has no accessibility violations
    Given I open the holiday entitlement calculator start page
    Then the main heading should be "Calculate holiday entitlement"
    And the page should have no accessibility violations
    And the page structure should match the "start-page" snapshot

  Scenario: A question page has no accessibility violations
    Given I start the calculator
    Then I should be asked "Does the employee work irregular hours or for part of the year?"
    And the page should have no accessibility violations
    And the page structure should match the "question-page" snapshot

  Scenario: A date question page has no accessibility violations
    Given I start the calculator
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting part way through a leave year" and continue
    Then I should be asked "What was the employment start date?"
    And the page should have no accessibility violations
    And the page structure should match the "date-question-page" snapshot

  Scenario: An error page has no accessibility violations
    Given I start the calculator
    When I continue without answering
    Then I should see the error "Please answer this question"
    And the page should have no accessibility violations
    And the page structure should match the "error-page" snapshot

  Scenario: An outcome page has no accessibility violations
    Given I start the calculator
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for a full leave year" and continue
    And I enter "5" and continue
    Then the outcome should say "The statutory holiday entitlement is 28 days holiday."
    And the page should have no accessibility violations
    And the page structure should match the "outcome-page" snapshot
