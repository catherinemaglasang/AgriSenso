import flask
import json
from flask import Flask, jsonify, request
from utils import spcall, InvalidRequest, clean_form, InvalidForm, build_json, DuplicateRow

app = Flask(__name__)


@app.route('/', methods=['GET'])
def index():
    return jsonify({"status": "OK", "message": "OK"})


@app.route('/products/', methods=['GET'])
@app.route('/products/<product_id>/', methods=['GET'])
def products_get(product_id=None):
    data = spcall('products_get', (product_id,), )
    response = build_json(data)

    if product_id and len(response['entries']) == 0:
        """ Product ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)

    return jsonify(response)


@app.route('/products/', methods=['POST'])
@app.route('/products/<product_id>/', methods=['PUT'])
def products_upsert(product_id=None):
    data = json.loads(request.data)

    if clean_form(data):
        response = spcall('products_upsert', (
            product_id,
            data['product_name'],
            data['description'],
            data['price'],
            str(data['date_added'],)))

        if product_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)

        json_dict = build_json(response)

        status_code = 200
        if not product_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/infos/', methods=['GET'])
@app.route('/infos/<info_id>/', methods=['GET'])
def attributes_get(info_id=None):
    data = spcall('infos_get', (info_id,), )

    response = build_json(data)

    if info_id and len(response['entries']) == 0:
        """ Product ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)

    return jsonify(response)


@app.route('/infos/', methods=['POST'])
@app.route('/infos/<info_id>/', methods=['PUT'])
def attributes_upsert(info_id=None):
    data = json.loads(request.data)

    if clean_form(data):

        response = spcall('infos_upsert', (
            info_id,
            data['_what'],
            data['_when'],
            data['_where'],
            data['_how'],
            str(data['date_added'],)))

        if info_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)

        json_dict = build_json(response)

        status_code = 200
        if not info_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/videos/', methods=['GET'])
@app.route('/videos/<video_id>/', methods=['GET'])
def videos_get(video_id=None):
    data = spcall('videos_get', (video_id,), )

    response = build_json(data)

    if video_id and len(response['entries']) == 0:
        """ Product ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)

    return jsonify(response)


@app.route('/videos/', methods=['POST'])
@app.route('/videos/<video_id>/', methods=['PUT'])
def videos_upsert(video_id=None):
    data = json.loads(request.data)

    if clean_form(data):

        response = spcall('videos_upsert', (
            video_id,
            data['video_name'],
            str(data['date_added'],)))

        if video_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)

        json_dict = build_json(response)

        status_code = 200
        if not video_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/products/<product_id>/infos/', methods=['GET'])
@app.route('/products/<product_id>/infos/<info_id>/', methods=['GET'])
def product_infos_get(product_id, info_id=None):
    response = spcall('product_infos_get', (info_id, product_id,),)

    json_dict = build_json(response)

    if info_id and len(json_dict['entries']) == 0:
        """ Product ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)

    return jsonify(json_dict)


@app.route('/products/<product_id>/infos/', methods=['POST'])
@app.route('/products/<product_id>/infos/<info_id>/', methods=['PUT'])
def product_infos_upsert(product_id, info_id=None):
    data = json.loads(request.data)

    if clean_form(data):

        response = spcall('product_infos_upsert', (
            info_id,
            product_id,
            str(data['date_added'],)))

        json_dict = build_json(response)

        status_code = 200
        if not info_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)  # Images


@app.route('/products/<product_id>/videos/', methods=['GET'])
@app.route('/products/<product_id>/videos/<video_id>/', methods=['GET'])
def product_videos_get(product_id, video_id=None):
    response = spcall('product_videos_get', (video_id, product_id,), )
    json_dict = build_json(response)

    if video_id and len(json_dict['entries']) == 0:
        """ Product ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)

    return jsonify(json_dict)


@app.route('/products/<product_id>/videos/', methods=['POST'])
@app.route('/products/<product_id>/videos/<video_id>/', methods=['PUT'])
def product_videos_upsert(product_id, video_id=None):
    data = json.loads(request.data)

    if clean_form(data):

        response = spcall('product_videos_upsert', (
            video_id,
            product_id,
            str(data['date_added'],)))

        json_dict = build_json(response)

        status_code = 200
        if not video_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)  # Images


@app.route('/notes/', methods=['GET'])
@app.route('/notes/<note_id>/', methods=['GET'])
def notes_get(note_id=None):
    data = spcall('notes_get', (note_id,), )
    response = build_json(data)
    if note_id and len(response['entries']) == 0:
        """ Note ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)
    return jsonify(response)


@app.route('/notes/', methods=['POST'])
@app.route('/notes/<note_id>/', methods=['PUT'])
def notes_upsert(note_id=None):
    data = json.loads(request.data)

    if clean_form(data):
        response = spcall('notes_upsert', (
            note_id,
            data['note_name'],
            data['description'],
            str(data['date_added'],)))

        if note_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)

        json_dict = build_json(response)

        status_code = 200
        if not note_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/sellers/', methods=['GET'])
@app.route('/sellers/<seller_id>/', methods=['GET'])
def getseller(seller_id=None):
    data = spcall('getsellers', (seller_id,), )
    response = build_json(data)

    if seller_id and len(response['entries']) == 0:
        """ Seller ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)
    return jsonify(response)


@app.route('/sellers/', methods=['POST'])
@app.route('/sellers/<seller_id>/', methods=['PUT'])
def seller_upsert(seller_id=None):
    data = json.loads(request.data)
    if clean_form(data):
        response = spcall('upsert_seller', (
            seller_id,
            data['first_name'],
            data['middle_name'],
            data['last_name'],
            data['email'],
            data['password'],
            data['age'],
            data['contact_number'],
            data['address'],))
        if seller_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)
        json_dict = build_json(response)
        status_code = 200
        if not seller_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/buyers/', methods=['GET'])
@app.route('/buyers/<buyer_id>/', methods=['GET'])
def getbuyer(buyer_id=None):
    data = spcall('getbuyers', (buyer_id,), )
    response = build_json(data)

    if buyer_id and len(response['entries']) == 0:
        """ Buyer ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)
    return jsonify(response)


@app.route('/buyers/', methods=['POST'])
@app.route('/buyers/<buyer_id>/', methods=['PUT'])
def buyer_upsert(buyer_id=None):
    data = json.loads(request.data)

    if clean_form(data):
        response = spcall('upsert_buyer', (
            buyer_id,
            data['first_name'],
            data['middle_name'],
            data['last_name'],
            data['email'],
            data['password'],
            data['age'],
            data['contact_number'],
            data['address'],))
        if buyer_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)
        json_dict = build_json(response)
        status_code = 200
        if not buyer_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/contacts/', methods=['POST'])
@app.route('/contacts/<contact_id>/', methods=['PUT'])
def contact_upsert(contact_id=None):
    data = json.loads(request.data)
    if clean_form(data):
        response = spcall('upsert_contact', (
            contact_id,
            data['c_number'],
            data['name'],
            data['l_name'],))

        if contact_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)
        json_dict = build_json(response)
        status_code = 200
        if not contact_id:
            status_code = 201

        return jsonify(json_dict), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/contacts/', methods=['GET'])
@app.route('/contacts/<contact_id>/', methods=['GET'])
def get_contact(contact_id=None):
    data = spcall('getcontacts', (contact_id,), )
    response = build_json(data)

    if contact_id and len(response['entries']) == 0:
        """ Contact ID does not exist """
        raise InvalidRequest('Does not exist', status_code=404)
    return jsonify(response)


# Handler

@app.errorhandler(InvalidForm)
def handle_invalid_form(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response


@app.errorhandler(InvalidRequest)
def handle_invalid_request(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response


@app.errorhandler(DuplicateRow)
def handle_duplicate_row(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response


@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging

    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp


if __name__ == '__main__':
    app.run(debug=True)

