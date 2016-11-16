Feature: Handle storing, retreiving details, update details

Scenario: Add seller

Given I have the following data:
|seller_id|first_name|middle_name|last_name|age|contact_number|address| 
|1|Marjorie|Galabin|Buctolan|19|09061233822|Pualas, Tubod, LDN|

When I post the information to resource_url ‘/api/sellers/’
Then I should have a response of  ‘200’
And It should have a status containing ‘OK’
And It should have a message containing ‘OK’