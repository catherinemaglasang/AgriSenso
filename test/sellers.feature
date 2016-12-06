Feature: Handle storing, retreiving details, update details

  Background:
    Given a resource url called "/sellers/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url         | status_code | status | message |
      | /           | 200         | OK     | OK      |
      | /sellers/   | 200         | OK     | OK      |
      | /sellers/1/ | 200         | OK     | OK      |


   Scenario: Get Sellers - Success!
    Given I access the url "/sellers/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

   Scenario: Get seller - 404 Error
    Given I access the url "/sellers/9999/"
    Then I get a "404" response
    And I get an "error" status
    And I get an "Does not exist" message

   Scenario: Add seller - Success!

	Given I have the ff data
	|seller_id|first_name|middle_name|last_name|email|age|contact_number|address| 
	|8|Marjorie|Galabin|Buctolan|marjbuctolan@gmail.com|19|09061233822|Pualas, Tubod, LDN|
	When I save the data
	Then I get a "201" response
	And I get a field "status" containing "OK"
	And I get a field "message" containing "OK"

   Scenario: Add Seller - Invalid

    Given I have a form
    And I have a field "seller_id" with value ""
    And I have a field "first_name" with value ""
    And I have a field "middle_name" with value ""
    And I have a field "last_name" with value ""
    And I have a field "email" with value ""
    And I have a field "age" with value ""
    And I have a field "contact_number" with value ""
    And I have a field "address" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"


  Scenario: Update Seller - Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
      |seller_id|first_name|middle_name|last_name|email|age|contact_number|address| 
	|1|Liza|Galabin|Buctolan|lizabuctolan@gmail.com|19|09061233822|Pualas, Tubod, LDN|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

   Scenario: Update Seller - Error, Info doesn't exist, raise 404
    Given I have a resource with the id "99999"
    And I want to update its data to the following data
    |seller_id|first_name|middle_name|last_name|email|age|contact_number|address| 
	|9999999|Marjorie|Galabin|Buctolan|marjbuctolan@gmail.com|19|09061233822|Pualas, Tubod, LDN|
    When I update the data
    Then I get a "404" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Does not exist"