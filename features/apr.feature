Feature Calculate APR
  In order to show sorted APR search results
  As a person navigating OMT
  I want to see correct APRs

  Scenario Outline: Calculate APR
    Given <loan_amount>, <fees>, <points>, <rate>, <period>
    Then the resultant apr should be <apr>

  Scenarios: with APR fields
    | loan_amount | fees  | points  | rate   | period | apr   |
    | 125000      | 5000  | 0       | 6.5    | 360    | 6.881 |
    | 125000      | 5000  | -1.25   | 6.5    | 360    | 6.881 |
    | 400000      | 1200  | 0       | 5.25   | 180    | 5.296 |
    | 125000      | 811   | 0.375   | 6.125  | 360    | 6.221 |
    | 125000      | 811   | -0.375  | 6.5    | 360    | 6.562 |
    | 100000      | 1000  | 0       | 7.0    | 360    | 7.099 |
    | 100000      | 0     | 0       | 7.0    | 360    | 7.0   |
    | 250000      | 3135  | 2.125   | 6.5    | 360    | 6.822 |
    | 80000       | 800   | 1.2     | 5.125  | 360    | 5.319 |