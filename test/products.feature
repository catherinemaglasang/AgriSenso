Feature: Get, Create & Update Products

  Background:
    Given a resource url called "/products/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url          | status_code | status | message |
      | /            | 200         | OK     | OK      |
      | /products/   | 200         | OK     | OK      |
      | /products/1/ | 200         | OK     | OK      |


  Scenario: Add Product - Success!
    Given I have the following data
    |product_id|product_name|description|price|date_added|
    |1|corn|healthy|28.00|2016-11-15 12:16:18|
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Get Product - Success!
    Given I access the url "/products/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

#  Scenario: Get product - 404 Error
#    Given I access the url "/products/9999/"
#    Then I get a "404" response
#    And I get an "error" status
#    And I get an "Does not exist" message

#  Scenario: Add Item - Not Validated Form Fields or Invalid Form Field Values
#    Given I have a form
#    And I have a field "product_id" with value ""
#    And I have a field "product_name" with value ""
#    And I have a field "description" with value ""
#    And I have a field "price" with value ""
#    And I have a field "date_added" with value ""
#    When the server processes the request
#    Then I get a "404" response
#    And I get a field "status" containing "error"
#    And I get a field "message" containing "Some fields have error values"
#
#  Scenario: Update Item - Success!
#    Given I have a resource with the id "1"
#    And I want to update its data to the following data
#      |product_id|product_name|description|price|date_added|
#      |1|corn beef|healthy|28.00|2016-11-15 12:16:18|
#    When I update the data
#    Then I get a "200" response
#    And I get a field "status" containing "OK"
#    And I get a field "message" containing "OK"

#  Scenario: Update Item - Error, Item doesn't exist, raise 404
#    Given I have a resource with the id "9999"
#    And I want to update its data to the following data
#      |product_id|product_name|description|price|date_added|
#      |9999|beans|healthy|28.00|2016-11-15 12:16:18|
#    When I update the data
#    Then I get a "404" response
#    And I get a field "status" containing "error"
#    And I get a field "message" containing "Does not exist"




