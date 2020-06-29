Feature: Consume the first eligible message from a kafka topic

  # This doesn't work, this is what we were looking to achieve
  @WhatWeWant
  Scenario: I can use json native syntax in a filter
    * def consume = read("classpath:consume.feature")
    Given def filter =
    """
    function(message) {
      karate.log("In Filter:" + message);
      karate.log("In Filter:" + message.correlationId);
      return message.correlationId == "101"
    }
    """
    When call consume ({ topic: "myKafkaTopic", filter: filter })
    Then match message contains { text: "Hello to everyone" }


  @NotWhatWeWant
  Scenario: I cannot use json native syntax in a filter
    * def consume = read("classpath:consume.feature")
    # Here we cannot work with json as native, rather as strings, this limits
    # us as we will have more complex filtering to isolate the messages we are looking for
    Given def filter = function(message) { return message.indexOf("101") >= 0 }
    When call consume ({ topic: "myKafkaTopic", filter: filter })
    # Also it would be nice for the message to be already in json native, when it is returned from consume.js
    # as we will also be working with xml
    * json messageJson = message
    Then match messageJson contains { text: "Hello to everyone" }


