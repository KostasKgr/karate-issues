Feature: Example

    Scenario: Example
      Given def message = { hello: "world" }
      Then match message == { hello: "world" }
