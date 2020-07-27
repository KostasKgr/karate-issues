Feature: Example
  Background:
    * def xml = read("this:file.xml")


  Scenario: Get xml works
    Given def message = get xml //hello
    Then match message == "world"

  Scenario: karate.xmlPath errors
    # Error thrown is: example.feature:11 - javascript evaluation failed: karate.xmlPath(xml, "//hello"), INVALID_CHARACTER_ERR: An invalid or illegal XML character is specified.

    #     public Object xmlPath(Object o, String path) {
    #        if (!(o instanceof Node)) {
    #            if (o instanceof Map) {
    #                o = XmlUtils.fromMap((Map) o);     <------ fails here, because the xml contains comments

    Given def message = karate.xmlPath(xml, "//hello")
    Then match message == "world"
