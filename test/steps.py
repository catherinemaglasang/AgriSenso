import json

from lettuce import *
from nose.tools import assert_equals
from app import app


@before.all
def before_all():
    world.browser = app.test_client()


@step('a resource url called "(.*)"')
def given_a_resource_url(step, url):
    """
    :type step: lettuce.core.Step
    """
    world.resource = url


# ----------------------------------------------------------------
# Common steps for retrieving data in any of the tables. We want to check its status, and fields.


@step('I access the url "(?P<url>.+)"')
def given_i_access_the_url_url(step, url):
    world.response = world.browser.get(url)
    world.response_data = json.loads(world.response.data)


@step('I get a "(?P<status_code>.+)" response')
def i_get_a_response(step, status_code):
    assert_equals(world.response.status_code, int(status_code))


@step('I get an "(?P<status>.+)" status')
def i_get_a_status(step, status):
    assert_equals(world.response_data['status'], status)


@step('I get an "(?P<message>.+)" message')
def i_get_a_message(step, message):
    assert_equals(world.response_data['message'], message)


# ----------------------------------------------------------------
# Common steps for adding data in any of the tables. We want to check its status, and fields.
@step("I have the following data")
def given_i_have_the_following_data(step):
    world.data = step.hashes[0]


@step('I save the data')
def i_post_to_the_url_url(step):
    world.response = world.browser.post(world.resource, data=json.dumps(world.data))
    world.response_data = json.loads(world.response.data)

@step('I have the ff data')
def i_post_the_data(step):
    world.data = step.hashes[0]

@step("I have a form")
def given_i_have_the_following_data(step):
    world.data = {}


@step('I have a field "(.*)" with value "(.*)"')
def i_have_a_field_with_value(step, field, field_value):
    world.data[field] = field_value


@step('the server processes the request')
def i_post_to_the_url_url(step):
    world.response = world.browser.post(world.resource, data=json.dumps(world.data))
    world.response_data = json.loads(world.response.data)


@step('I get a field "(.*)" containing "(.*)"')
def i_get_a_field_field_containing_value(step, field, field_value):
    print world.response_data
    assert_equals(world.response_data[field], field_value)


# ----------------------------------------------------------------
# Common steps for updating data in any of the tables.

@step('I have a resource with the id "(.*)"')
def i_have_a_resource_with_id_id(step, id):
    world.resource_id = id


@step('I want to update an existing data')
def i_want_to_update_an_existing_data(step):
    world.resource_id = id


@step("I want to update its data to the following data")
def i_want_to_update_its_data(step):
    world.new_data = step.hashes[0]


@step("I update the data")
def i_send_a_put_request_from_client(step):
    url = world.resource + world.resource_id + "/"
    world.response = world.browser.put(url, data=json.dumps(world.new_data))
    print world.response
    world.response_data = json.loads(world.response.data)


@step(u'Given I have the following data:')
def given_seller_data(step):
    world.d = step.hashes[0]

@step(u'When I post the information to resource_url "(?P<url>.+)"')
def post(step):
    world.bwowser = TestAppp(app)
    world.seller_uri = '/addsellers/'
    world.response = world.app.post(world.seller_uri, data = json.dumps(world.fill))
    
@step(u'Then I should have a response of  \'(.*)\'')
def response(step, expected_status_code):
    assert_equals((world.response.status_code, int(expected_status_code)))

@step(u'And it should have a field "status" containing "OK"')
def status_field(step):
    world.rsp = json.loads(world.response.data)
    assert_equals(world.rsp['status'], "OK")