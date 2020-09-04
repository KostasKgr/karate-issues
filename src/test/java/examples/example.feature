
Feature: example
  Background:
    * def catProvider = Java.type("examples.CatProvider")

    * def catMaps = catProvider.getCatsAsMap(3)
    * def cats = catProvider.getCats(3)

  Scenario Outline: Learn more about cat <id>
    * print karate.info.scenarioName
    * print __row


    Examples:
      | cats |


  Scenario Outline: Learn more about catMap <id>
    * print karate.info.scenarioName
    * print __row


    Examples:
      | catMaps |