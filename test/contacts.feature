Feature: Get, Create & Update Contacts

  Background:
    Given a resource url called "/contacts/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url       | status_code | status | message |
      | /         | 200         | OK     | OK      |
      | /contacts/   | 200         | OK     | OK      |
      | /contacts/1/ | 200         | OK     | OK      |

  Scenario: Get Note - Success!
    Given I access the url "/contacts/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

  Scenario: Get Note - 404 Error
    Given I access the url "/contacts/9999/"
    Then I get a "404" response
    And I get an "error" status
    And I get an "Does not exist" message

  Scenario: Add contact - Success!
    Given I have the following data
     |contact_id|c_number|name|l_name|
     |1|09359145088|Liza|Sobereano|
    When I save the data
    Then I get a "201" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Add Contact - Not Validated Form Fields or Invalid Form Field Values
    Given I have a form
    And I have a field "contact_id" with value ""
    And I have a field "c_number" with value ""
    And I have a field "name" with value ""
    And I have a field "l_name" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"

  Scenario: Update Contact - Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
      |contact_id|c_number|name|l_name|
      |1|950250985352|John|Legend|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Update contact - Error, contact doesn't exist, raise 404
    Given I have a resource with the id "99999"
    And I want to update its data to the following data
      |contact_id|c_number|name|l_name|
      |99999|096742374627|Marj|Buctolan|
    When I update the data
    Then I get a "404" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Does not exist"