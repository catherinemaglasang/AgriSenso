Feature: Get, Create & Update Product Videos

  Background:
    Given a resource url called "/products/1/videos/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url                   | status_code | status | message |
      | /                     | 200         | OK     | OK      |
      | /products/            | 200         | OK     | OK      |
      | /products/1/          | 200         | OK     | OK      |
      | /products/1/videos/   | 200         | OK     | OK      |
      | /products/1/videos/1/ | 200         | OK     | OK      |


  Scenario: Get Product Videos- Success!
    Given I access the url "/products/1/videos/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

  Scenario: Add Product Videos- Success!
    Given I have the following data
     |video_id|product_id|date_added |
     |1|1|2016-11-15 12:16:18|
    When I save the data
    Then I get a "201" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Add Product Video - Not Validated Form Fields or Invalid Form Field Values
    Given I have a form
    And I have a field "video_id" with value ""
    And I have a field "product_id" with value ""
    And I have a field "date_added" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"

  Scenario: Update Item - Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
      |video_id|product_id|date_added|
      |1|1|2016-11-15|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"
