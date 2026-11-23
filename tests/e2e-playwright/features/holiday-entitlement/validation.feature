@holiday-entitlement @validation @regression
Feature: Holiday entitlement calculator validation
  As a user
  I want to be told when an answer is not valid
  So that I can correct it before I see a result

  Background:
    Given I start the calculator

  Scenario: Continuing without choosing an answer
    When I continue without answering
    Then I should see the error "Please answer this question"
    And I should be asked "Does the employee work irregular hours or for part of the year?"

  Scenario: Leaving the days worked per week blank
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for a full leave year" and continue
    And I continue without answering
    Then I should see the error "There are only 7 days in a week"
    And I should be asked "Number of days worked per week?"

  Scenario Outline: Days worked per week outside 1 to 7 is rejected
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for a full leave year" and continue
    And I enter "<days>" and continue
    Then I should see the error "There are only 7 days in a week"
    And I should be asked "Number of days worked per week?"

    Examples:
      | days |
      | 0    |
      | 8    |
      | -1   |
      | 0.5  |
      | abc  |

  Scenario Outline: Hours worked per week outside the allowed range is rejected
    When I select "No" and continue
    And I select "hours worked per week" and continue
    And I select "for a full leave year" and continue
    And I enter "<hours>" and continue
    Then I should see the error "<error>"
    And I should be asked "Number of hours worked per week?"

    Examples:
      | hours | error                                         |
      | 169   | You can enter a maximum of 168 hours per week |
      | 0     | Please enter at least .5 hours worked         |
      | -5    | Please enter at least .5 hours worked         |
      | abc   | Please answer this question                   |
