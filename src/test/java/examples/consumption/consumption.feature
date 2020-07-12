Feature: Consume the first eligible message from a kafka topic

  # This doesn't work, this is what we were looking to achieve
  @WhatWeWant
  Scenario: I can use json native syntax in a filter, without having to parse json in Java
    * def kafka_message_format = "automatic"
    * def consume = read("classpath:consume.feature")
    Given def filter =
    """
    function(message) {
      karate.log("In filter, message:", message)
      karate.log("Correlation id:", message.correlationId)
      return message.correlationId == "101"
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }


  # This works but would seem better to do the string to json conversion in karate
  Scenario: Filters work if we parse json in the java layer, simple equality checks
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "json"
    Given def filter =
    """
    function(message) {
      return message.correlationId == "101"
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }


  Scenario: Filters work if we parse json in the java layer, nested checks
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "json"
    Given def filter =
    """
    function(message) {
      return message.data.deeply.nested == "no"
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }
    Then match message contains { data: { deeply: { nested: "no" } } } }

  # TODO cannot use match contains
  Scenario: Match contains does not work with karate.match
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "json"
    Given def filter =
    """
    function(message) {
      return karate.match(message, { data: { deeply: { nested: "no" } } }).pass
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }

  # TODO deeply nested checks with wrong path fail, is this expected?
  Scenario: Deeply nested checks throw exceptions instead of not matching
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "json"
    Given def filter =
    """
    function(message) {
      return message.nonExistent.deeply.nested == "no"
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }



  # TODO deeply nested checks with wrong path fail with karate.match as well
  #      probably cannot use jsonpath at all in the js DSL?
  #      maybe if there was a karate.match(object, jsonPath, expected) ?
  # hypothesis is that there can be many different message types in a topic
  # e.g. think of event sourcing, and not all of them have the same structure
  # but in this case we can short circuit to avoid exceptions
  Scenario: Deeply nested checks throw exceptions instead of not matching, even with karate.match
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "json"
    Given def filter =
    """
    function(message) {
      return karate.match(message.nonExistent.deeply.nested, "no")
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }


  Scenario: Deeply nested json path seems to work great in stepactions, reports not match null instead of exception
    * def message =
    """
    {
        "correlationId": "101",
        "text": "Hello to everyone",
        "data": {
            "deeply": {
                "nested": "no",
                "id": "1010"
            }
        }
    }
    """
    Then match message contains { text: "Hello to everyone" }
    # Getting  path: $.nonExistent.deeply.nested, actual: null, expected: 'no', reason: actual json-path does not exist
    Then match message.nonExistent.deeply.nested == "no"

