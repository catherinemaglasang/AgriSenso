Feature: Get, Create & Update Videos

  Background:
    Given a resource url called "/videos/"

  Scenario Outline: Retrieve resource
    Given I access the url "<url>"
    Then I get a "<status_code>" response
    And I get an "<status>" status
    And I get an "<message>" message

    Examples:
      | url       | status_code | status | message |
      | /         | 200         | OK     | OK      |
      | /videos/   | 200         | OK     | OK      |
      | /videos/1/ | 200         | OK     | OK      |

  Scenario: Get Video - Success!
    Given I access the url "/videos/1/"
    Then I get a "200" response
    And I get an "OK" status
    And I get an "OK" message

  Scenario: Get Video - 404 Error
    Given I access the url "/videos/9999/"
    Then I get a "404" response
    And I get an "error" status
    And I get an "Does not exist" message

  Scenario: Add Video - Success!
    Given I have the following data
     |video_id|video_name|date_added |
     |1|video.mp4|2016-11-15 12:16:18|
    When I save the data
    Then I get a "201" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Add Video - Not Validated Form Fields or Invalid Form Field Values
    Given I have a form
    And I have a field "video_id" with value ""
    And I have a field "video_name" with value ""
    And I have a field "date_added" with value ""
    When the server processes the request
    Then I get a "422" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Some fields have error values"

  Scenario: Update Video - Success!
    Given I have a resource with the id "1"
    And I want to update its data to the following data
      |video_id|video_name|date_added |
      |1|video_update.mp4|2016-11-15 12:16:18|
    When I update the data
    Then I get a "200" response
    And I get a field "status" containing "OK"
    And I get a field "message" containing "OK"

  Scenario: Update Video - Error, Video doesn't exist, raise 404
    Given I have a resource with the id "99999"
    And I want to update its data to the following data
      |video_id|video_name|date_added |
      |9999|video_update.mp4|2016-11-15 12:16:18|
    When I update the data
    Then I get a "404" response
    And I get a field "status" containing "error"
    And I get a field "message" containing "Does not exist"