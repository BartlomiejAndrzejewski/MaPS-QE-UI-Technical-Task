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

        Scenario Outline: Statutory holiday for someone starting part way through a leave year
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting part way through a leave year" and continue
    And I enter the date "<startDay>" "<startMonth>" "<startYear>" and continue
    Then I should be asked "When does the leave year start?"
    When I enter the date "<leaveDay>" "<leaveMonth>" "<leaveYear>" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "<days>" and continue
    Then the outcome should say "The statutory holiday entitlement is <entitlement> days holiday."

    Examples:
      | startDay | startMonth | startYear | leaveDay | leaveMonth | leaveYear | days | entitlement |
      | 15       | 3          | 2026      | 1        | 1          | 2026      | 3    | 14          |
      | 31       | 12         | 2026      | 1        | 1          | 2026      | 5    | 2.5         |
      | 1        | 6          | 2026      | 1        | 4          | 2026      | 5    | 23.5        |

  Scenario Outline: Statutory holiday for someone leaving part way through a leave year
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone leaving part way through a leave year" and continue
    And I enter the date "<endDay>" "<endMonth>" "<endYear>" and continue
    Then I should be asked "When does the leave year start?"
    When I enter the date "<leaveDay>" "<leaveMonth>" "<leaveYear>" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "<days>" and continue
    Then the outcome should say "The statutory holiday entitlement is <entitlement> days holiday."

    Examples:
      | endDay | endMonth | endYear | leaveDay | leaveMonth | leaveYear | days | entitlement |
      | 30     | 6        | 2026    | 1        | 1          | 2026      | 5    | 13.9        |
      | 31     | 12       | 2026    | 1        | 1          | 2026      | 5    | 28          |

  Scenario Outline: Statutory holiday for someone starting and leaving part way through a leave year
    When I select "No" and continue
    And I select "days worked per week" and continue
    And I select "for someone starting and leaving part way through a leave year" and continue
    And I enter the date "<startDay>" "<startMonth>" "<startYear>" and continue
    Then I should be asked "What was the employment end date?"
    When I enter the date "<endDay>" "<endMonth>" "<endYear>" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "<days>" and continue
    Then the outcome should say "The statutory holiday entitlement is <entitlement> days holiday."

    Examples:
      | startDay | startMonth | startYear | endDay | endMonth | endYear | days | entitlement |
      | 1        | 3          | 2026      | 30     | 9        | 2026    | 5    | 16.5        |
      | 1        | 3          | 2026      | 30     | 9        | 2026    | 3    | 9.9         |
      | 1        | 3          | 2026      | 2      | 3        | 2026    | 5    | 0.2         |
      | 1        | 1          | 2026      | 31     | 12       | 2026    | 5    | 28          |
