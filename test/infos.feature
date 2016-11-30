Feature: Get, Create & Update Notes

  Background:
    Given a resource url called "/infos/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url       | status_code | status | message |
      | /         | 200         | OK     | OK      |
      | /infos/   | 200         | OK     | OK      |
      | /infos/1/ | 200         | OK     | OK      |

  Scenario: Get Info - Success!
    Given I access the url "/infos/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

  Scenario: Get Info - 404 Error
    Given I access the url "/infos/9999/"
    Then I get a "404" response
    And I get an "error" status
    And I get an "Does not exist" message

  Scenario: Add Info - Success!
    Given I have the following data
     |info_id|_what|_when|_where|_how|date_added |
     |1|whatwhat|whenwhen|wherewhere|howhow|2016-11-15 12:16:18|
    When I save the data
    Then I get a "201" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Add Info - Not Validated Form Fields or Invalid Form Field Values
    Given I have a form
    And I have a field "info_id" with value ""
    And I have a field "_what" with value ""
    And I have a field "_when" with value ""
    And I have a field "_where" with value ""
    And I have a field "_how" with value ""
    And I have a field "date_added" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"

  Scenario: Update Info - Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
      |info_id|_what|_when|_where|_how|date_added |
      |1|whatupdate|whenupdate|wherewhere|howhow|2016-11-15 12:16:18|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Update Info - Error, Info doesn't exist, raise 404
    Given I have a resource with the id "99999"
    And I want to update its data to the following data
      |info_id|_what|_when|_where|_how|date_added |
      |9999|whatwhat|whenwhen|wherewhere|howhow|2016-11-15 12:16:18|
    When I update the data
    Then I get a "404" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Does not exist"