Feature: Example

  Scenario Outline: Example exception with message, straight from eval of java
# Actual stack trace is something like the following:
#  java.lang.NumberFormatException: For input string: "notInteger!"
#
#     at java.base/java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
#     at java.base/java.lang.Integer.parseInt(Integer.java:652)
#     at java.base/java.lang.Integer.parseInt(Integer.java:770)

# Karate output:
#     example.feature:13 - javascript evaluation failed: java.lang.Integer.parseInt("notANumber"), For input string: "notANumber"

# Karate output with https://github.com/intuit/karate/commit/608895d6d958deebed7ab942b2cf6d2d170b9d1c :
#     example.feature:13 - evaluation (js) failed: java.lang.Integer.parseInt("notANumber"), For input string: "notANumber"
#     stack trace: java.base/java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)

# Karate output with e.toString()
#  example.feature:16 - evaluation (js) failed: java.lang.Integer.parseInt("notANumber"), java.lang.NumberFormatException: For input string: "notANumber"
#  stack trace: java.base/java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
    Given def number = java.lang.Integer.parseInt("<number>")
    Then print number

    Examples:
      | number     |
      | 10         |
      | notANumber |


  Scenario: Example exception without message from java
# Actual stack trace is something like the following:
#  java.util.ConcurrentModificationException
#     at examples.NoMessageException.error(NoMessageException.java:8)
#     at examples.ExamplesRunner.exceptionFromJava(ExamplesRunner.java:22)

# Karate output with https://github.com/intuit/karate/commit/608895d6d958deebed7ab942b2cf6d2d170b9d1c :
#  example.feature:31 - evaluation (js) failed: e.error(), e.error()
#  stack trace: examples.NoMessageException.error(NoMessageException.java:8)

# Karate output with e.toString()
#  example.feature:35 - evaluation (js) failed: e.error(), java.util.ConcurrentModificationException
#  stack trace: examples.NoMessageException.error(NoMessageException.java:8)
    Given def e = Java.type("examples.NoMessageException")
    Then e.error()


  Scenario: Example exception from a js file
# Actual stack trace is something like the following:
#  java.util.ConcurrentModificationException
#     at examples.NoMessageException.error(NoMessageException.java:8)
#     at examples.ExamplesRunner.exceptionFromJava(ExamplesRunner.java:22)

# Karate output:
#      Throwing an exception without a message
#      23:57:00.900 [ForkJoinPool-1-worker-3] ERROR com.intuit.karate - javascript function call failed: null
#      23:57:00.901 [ForkJoinPool-1-worker-3] ERROR com.intuit.karate - failed function body: function() {
#      var e = Java.type("examples.NoMessageException")
#      e.error()
#      }
#
#      example.feature:58 - javascript function call failed: null

# Karate output with e.toString() in evalJsFunctionCall
#      Throwing an exception without a message
#      00:00:51.032 [ForkJoinPool-1-worker-3] ERROR com.intuit.karate - javascript function call failed: java.util.ConcurrentModificationException
#      00:00:51.033 [ForkJoinPool-1-worker-3] ERROR com.intuit.karate - failed function body: function() {
#      var e = Java.type("examples.NoMessageException")
#      e.error()
#      }
#
#      example.feature:65 - javascript function call failed: java.util.ConcurrentModificationException

    Given call read("this:exception.js")
