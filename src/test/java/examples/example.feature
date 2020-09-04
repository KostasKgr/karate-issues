
Feature: example
  Background:
    * def catProvider = Java.type("examples.CatProvider")
    * print "Calulating cat map"
    * def catMaps = catProvider.getCatsAsMap(1000)
    * print "Cat map has been calulated"

  Scenario Outline: Learn more about catMap <id>
    * print karate.info.scenarioName
    * print __row


    Examples:
      | catMaps |