Feature: Consume the first eligible message from a kafka topic

  Background:
    * def kafka_message_format = "STRING"

  # This doesn't work, this is what we were looking to achieve
  @WhatWeWant
  Scenario: I can use json native syntax in a filter, without having to parse json in Java
    * def consume = read("classpath:consume.feature")
    Given def filter =
    """
    function(message) {
      return message.correlationId == "101"
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }


  # This works but would seem better to do the string to json conversion in karate
  Scenario: Filters work if we parse json in the java layer, simple equality checks
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "JSON"
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
    * def kafka_message_format = "JSON"
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
    * def kafka_message_format = "JSON"
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
    * def kafka_message_format = "JSON"
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
  Scenario: Deeply nested checks throw exceptions instead of not matching, even with karate.match
    * def consume = read("classpath:consume.feature")
    * def kafka_message_format = "JSON"
    Given def filter =
    """
    function(message) {
      return karate.match(message.nonExistent.deeply.nested, "no")
    }
    """
    When call consume ({ topic: "json.topic", filter: filter })
    Then match message contains { text: "Hello to everyone" }

  Scenario: If records are string and no conversion happens, we have basic string based filters only
    * def consume = read("classpath:consume.feature")
    # Here we cannot work with json as native, and have to work with strings, this limits
    # us as we will have more complex filtering to isolate the messages we are looking for
    Given def filter = function(message) { return message.indexOf("101") >= 0 }
    When call consume ({ topic: "json.topic", filter: filter })
    # Also it would be nice for the message to be already in json native, when it is returned from consume.js
    # as we will also be working with xml
    * json messageJson = message
    Then match messageJson contains { text: "Hello to everyone" }


