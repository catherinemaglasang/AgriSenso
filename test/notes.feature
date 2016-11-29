Feature: Get, Create & Update Notes

  Background:
    Given a resource url called "/notes/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url       | status_code | status | message |
      | /         | 200         | OK     | OK      |
      | /notes/   | 200         | OK     | OK      |
      | /notes/1/ | 200         | OK     | OK      |


  Scenario: Add notes - Success!
    Given I have the following data
     |id|name|description|date_added |
     |1|corn|healthy|2016-11-15 12:16:18|
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Get Product - Success!
    Given I access the url "/notes/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message