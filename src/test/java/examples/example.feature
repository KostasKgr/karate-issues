Feature: Example feature

  Scenario Outline: Example scenario <mpla>
    Given print karate.info.scenarioName
    Given print "Hello <mpla>"

    Examples:
      | mpla |
      | 1    |
      | 2    |