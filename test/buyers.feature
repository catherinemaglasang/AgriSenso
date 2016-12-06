Feature: Handle storing, retreiving details, update details

  Background:
    Given a resource url called "/buyers/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url         | status_code | status | message |
      | /           | 200         | OK     | OK      |
      | /buyers/   | 200         | OK     | OK      |
      | /buyers/1/ | 200         | OK     | OK      |

   Scenario: Get buyer - 404 Error
    Given I access the url "/buyers/9999/"
    Then I get a "404" response
    And I get an "error" status
    And I get an "Does not exist" message

   Scenario: Get Buyers - Success!
    Given I access the url "/buyers/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

   Scenario: Add buyer - Success!

	  Given I have a form with the ff data
	 |buyer_id|first_name|middle_name|last_name|email|password|age|contact_number| address| 
	 |1|Catherine|Basay|Maglasang|maglasangcatherine12@gmail.com|asdasd|19|09252979173|Abuno, Iligan City|
	  When I save the data
	  Then I get a "201" response
	  And I get a field "status" containing "OK"
	  And I get a field "message" containing "OK"

   Scenario: Add Buyer - Invalid

    Given I have a form
    And I have a field "buyer_id" with value ""
    And I have a field "first_name" with value ""
    And I have a field "middle_name" with value ""
    And I have a field "last_name" with value ""
    And I have a field "email" with value ""
    And I have a field "password" with value ""
    And I have a field "age" with value ""
    And I have a field "contact_number" with value ""
    And I have a field "address" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"


  Scenario: Update Buyer- Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
    |buyer_id|first_name|middle_name|last_name|email|password|age|contact_number|address| 
	  |1|Nadine|Basay|Maglasang|maglasangnadine12@gmail.com|asdasd|19|09061233822|Pualas, Tubod, LDN|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Update Buyer- Error, Info doesn't exist, raise 404
    Given I have a resource with the id "99999"
    And I want to update its data to the following data
    |buyer_id|first_name|middle_name|last_name|email|password|age|contact_number|address| 
    |9999999|Nadine|Basay|Maglasang|maglasangnadine12@gmail.com|asdasd|19|09061233822|Pualas, Tubod, LDN|
    When I update the data
    Then I get a "404" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Does not exist"