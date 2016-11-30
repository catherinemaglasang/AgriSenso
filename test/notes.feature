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

  Scenario: Get Note - Success!
    Given I access the url "/notes/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

  Scenario: Get Note - 404 Error
    Given I access the url "/notes/9999/"
    Then I get a "404" response
    And I get an "error" status
    And I get an "Does not exist" message

  Scenario: Add Note - Success!
    Given I have the following data
     |note_id|note_name|description|date_added |
     |1|corn|healthy|2016-11-15 12:16:18|
    When I save the data
    Then I get a "201" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Add Note - Not Validated Form Fields or Invalid Form Field Values
    Given I have a form
    And I have a field "note_id" with value ""
    And I have a field "note_name" with value ""
    And I have a field "description" with value ""
    And I have a field "date_added" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"

  Scenario: Update Note - Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
      |note_id|note_name|description|date_added |
      |1|corn_update|healthy|2016-11-15 12:16:18|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Update Note - Error, Note doesn't exist, raise 404
    Given I have a resource with the id "99999"
    And I want to update its data to the following data
      |note_id|note_name|description|date_added|
      |99999|corn|healthy|2016-11-15|
    When I update the data
    Then I get a "404" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Does not exist"