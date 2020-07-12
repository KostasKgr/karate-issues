Feature: Example

    # https://www.w3.org/TR/xml/#sec-prolog-dtd
    Scenario: Example
      Given def nativeXML =
      """
      <?xml version="1.0" encoding="UTF-8" ?>
      <greeting>Hello world</greeting>
      """
      When string nativeToString = nativeXML
      * print nativeToString
      Then assert nativeToString.contains("encoding")

