@holiday-entitlement @calculation @regression
Feature: Holiday entitlement calculator calculations
  As a user
  I want the calculator to work out my statutory holiday entitlement
  So that I can see the correct amount for my working pattern

  Background:
    Given I start the calculator

  Scenario Outline: Statutory holiday for a full leave year by days worked per week
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for a full leave year" and continue
    And I enter "<days>" and continue
    Then the outcome should say "The statutory holiday entitlement is <entitlement> days holiday."

    Examples:
      | days | entitlement |
      | 1    | 5.6         |
      | 2    | 11.2        |
      | 3    | 16.8        |
      | 4    | 22.4        |
      | 5    | 28          |
      | 6    | 28          |
      | 7    | 28          |
      | 5.5  | 28          |

  Scenario: Working more than five days a week is capped at 28 days
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for a full leave year" and continue
    And I enter "7" and continue
    Then the outcome should say "The statutory holiday entitlement is 28 days holiday."
    And the outcome should say "Even though more than 5 days a week are worked, the maximum statutory holiday entitlement is 28 days."

  Scenario Outline: Statutory holiday for a full leave year by hours worked per week
    When I select "No" and continue
    And I select "hours worked per week" and continue
    And I select "for a full leave year" and continue
    And I enter "<hours>" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "<days>" and continue
    Then the outcome should say "The statutory entitlement is <entitlement> hours holiday."

    Examples:
      | hours | days | entitlement |
      | 37.5  | 5    | 210         |
      | 20    | 3    | 112         |
      | 8     | 1    | 44.8        |
      | 45.5  | 5    | 254.8       |
      | 40    | 6    | 186.7       |
      | 168   | 7    | 672         |
