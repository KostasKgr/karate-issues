Feature: Example

  Background:
    * def prepare_data = call read("this:data_prep.feature")
    * def data = prepare_data.data

  Scenario Outline: Executing for <name>
    * print name
    * print stats

    Examples:
      | data |
