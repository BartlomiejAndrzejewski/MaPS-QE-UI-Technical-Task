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
    Then I should be asked "Number of days worked per week?"
    When I continue without answering
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

  Scenario: An impossible employment start date is rejected
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting part way through a leave year" and continue
    And I enter the date "30" "2" "2026" and continue
    Then I should see the error "Please answer this question"
    And I should be asked "What was the employment start date?"

  Scenario: An employment start date before the leave year start is rejected
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting part way through a leave year" and continue
    And I enter the date "1" "12" "2025" and continue
    Then I should be asked "When does the leave year start?"
    When I enter the date "1" "1" "2026" and continue
    Then I should see the error "Your leave year start date must be earlier than your employment start date of 01 December 2025."
    And I should be asked "When does the leave year start?"

  Scenario: An employment start date more than a year after the leave year start is rejected
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting part way through a leave year" and continue
    And I enter the date "1" "1" "2027" and continue
    Then I should be asked "When does the leave year start?"
    When I enter the date "1" "1" "2026" and continue
    Then I should see the error "Your employment start date of 01 January 2027 must be within 1 year of the leave year start date."
    And I should be asked "When does the leave year start?"

  Scenario: An end date that is not after the start date is rejected
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting and leaving part way through a leave year" and continue
    And I enter the date "1" "3" "2026" and continue
    Then I should be asked "What was the employment end date?"
    When I enter the date "1" "3" "2026" and continue
    Then I should see the error "Your end date can not be before your start date of 01 March 2026."
    And I should be asked "What was the employment end date?"

  Scenario Outline: Hours worked in a pay period must be a number above zero
    When I select "Yes" and continue
    And I enter the date "1" "1" "2026" and continue
    Then I should be asked "How many hours has the employee worked in the pay period?"
    When I enter "<hours>" and continue
    Then I should see the error "<error>"
    And I should be asked "How many hours has the employee worked in the pay period?"

    Examples:
      | hours | error                                      |
      | 0     | You need to enter a number greater than 0  |
      | -5    | You need to enter a number greater than 0  |
      | abc   | Please answer this question                |

  Scenario: A shift pattern with fewer days than shifts is rejected
    When I select "No" and continue
    And I select "shifts" and continue
    And I select "for a full leave year" and continue
    Then I should be asked "How many hours in each shift?"
    When I enter "8" and continue
    Then I should be asked "How many shifts will be worked per shift pattern?"
    When I enter "5" and continue
    Then I should be asked "How many days in the shift pattern?"
    When I enter "3" and continue
    Then I should see the error "You need to enter a number greater than or equal to the number of shifts you work"
    And I should be asked "How many days in the shift pattern?"
