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

        Scenario Outline: Holiday accrued in a pay period for irregular hours
    When I select "Yes" and continue
    And I enter the date "1" "1" "2026" and continue
    Then I should be asked "How many hours has the employee worked in the pay period?"
    When I enter "<hours>" and continue
    Then the outcome should say "The statutory entitlement for this pay period is <entitlement>."

    Examples:
      | hours | entitlement |
      | 100   | 12 hours    |
      | 10    | 1 hour      |
      | 1     | 0 hours     |
      | 0.5   | 0 hours     |

  Scenario Outline: Statutory holiday for compressed hours
    When I select "No" and continue
    And I select "compressed hours" and continue
    And I select "for a full leave year" and continue
    And I enter "<hours>" and continue
    Then I should be asked "Number of days worked per week?"
    When I enter "<days>" and continue
    Then the outcome should say "The statutory holiday entitlement is <entitlement> holiday for the year."

    Examples:
      | hours | days | entitlement              |
      | 40    | 4    | 224 hours and 0 minutes  |
      | 37    | 4    | 207 hours and 12 minutes |

  Scenario Outline: Statutory holiday for shift workers
    When I select "No" and continue
    And I select "shifts" and continue
    And I select "for a full leave year" and continue
    Then I should be asked "How many hours in each shift?"
    When I enter "<hours>" and continue
    Then I should be asked "How many shifts will be worked per shift pattern?"
    When I enter "<shifts>" and continue
    Then I should be asked "How many days in the shift pattern?"
    When I enter "<patternDays>" and continue
    Then the outcome should say "The statutory holiday entitlement is <entitlement> shifts for the year."

    Examples:
      | hours | shifts | patternDays | entitlement |
      | 8     | 5      | 7           | 28          |
      | 8     | 5      | 14          | 14          |
