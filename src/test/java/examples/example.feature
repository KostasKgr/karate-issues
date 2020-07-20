Feature: Example

    Scenario: Example
      Given def amazing = Java.type('examples.Amazing')
      Then amazing.doWork()
      Then print "Logs from feature files work"
