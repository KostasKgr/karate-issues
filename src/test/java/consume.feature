@ignore
Feature:

  Scenario:
    * def consume_function = read("this:consume.js")
    * def message = consume_function(topic, filter)

