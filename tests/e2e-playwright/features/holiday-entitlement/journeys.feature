@holiday-entitlement @journey @regression
Feature: Holiday entitlement calculator journeys
  As a user
  I want to answer the calculator's questions
  So that I can see my statutory holiday entitlement

  Background:
    Given I start the calculator
    Then I should be asked "Does the employee work irregular hours or for part of the year?"

  Scenario: Days worked per week for a full leave year
    When I select "No" and continue
    Then I should be asked "Is the holiday entitlement based on:"
    When I select "days worked per week" and continue
    Then I should be asked "Do you want to work out holiday:"
    When I select "for a full leave year" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "5" and continue
    Then the outcome should say "28 days holiday"

  Scenario: Hours worked per week for a full leave year
    When I select "No" and continue
    And I select "hours worked per week" and continue
    And I select "for a full leave year" and continue
    Then I should be asked "Number of hours worked per week?"
    When I enter "40" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "5" and continue
    Then the outcome should say "224 hours holiday"

  Scenario: Annualised hours for a full leave year
    When I select "No" and continue
    And I select "annualised hours" and continue
    And I select "for a full leave year" and continue
    Then the outcome should say "5.6 weeks holiday"

  Scenario: Days worked per week for someone starting part way through a leave year
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting part way through a leave year" and continue
    Then I should be asked "What was the employment start date?"
    When I enter the date "1" "6" "2026" and continue
    Then I should be asked "When does the leave year start?"
    When I enter the date "1" "1" "2026" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "5" and continue
    Then the outcome should say "16.5 days holiday"

  Scenario: Irregular hours for one pay period
    When I select "Yes" and continue
    Then I should be asked "When does the leave year start?"
    When I enter the date "1" "1" "2026" and continue
    Then I should be asked "How many hours has the employee worked in the pay period?"
    When I enter "20" and continue
    Then the outcome should say "The statutory entitlement for this pay period is 2 hours."
