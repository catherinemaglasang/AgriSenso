from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
import json

""" Add a seller"""

@step(u'Given I have the following data:')
def given_seller_data(step):
	world.d = step.hashes[0]

@step(u'When I post the information to resource_url '/api/sellers/'')
def post(step):
	world.bwowser = TestAppp(app)
	world.seller_uri = '/api/addsellers/'
	world.response = world.app.post(world.seller_uri, data = json.dumps(world.fill))
	
@step(u'Then I should have a response of  \'(.*)\'')
def response(step, expected_status_code):
	assert_equals((world.response.status_code, int(expected_status_code)))

@step(u'And it should have a field "status" containing "OK"')
def status_field(step):
	world.rsp = json.loads(world.response.data)
	assert_equals(world.rsp['status'], "OK")