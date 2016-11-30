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


@app.route('/products/<product_id>/infos/', methods=['GET'])
@app.route('/products/<product_id>/infos/<info_id>/', methods=['GET'])
def product_infos_get(product_id, info_id=None):
    response = spcall('product_infos_get', (info_id, product_id,),)
    if 'Error' in str(response[0][0]):
        return jsonify({'status': 'error', 'message': response[0][0]})

    recs = []
    for r in response:
        recs.append({'product_id': r[0], 'info_id': r[1]})
    return jsonify({'status': 'OK', 'message': 'OK', 'entries': recs, 'count': len(recs)})


@app.route('/products/<product_id>/infos/', methods=['POST'])
@app.route('/products/<product_id>/infos/<info_id>/', methods=['PUT'])
def product_infos_upsert(product_id, info_id=None):
    data = json.loads(request.data)

    if clean_form(data):

        response = spcall('product_infos_upsert', (
            info_id,
            product_id,
            data['_what'],
            data['_when'],
            data['_where'],
            data['_how'],
            str(data['date_added']),),)

        if info_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)

        if 'Error' in str(response[0][0]):
            return jsonify({'status': 'error', 'message': response[0][0]})

        recs = []
        for r in response:
            recs.append({"info_id": r[0], "product_id": r[1]})

            status_code = 200
            if not info_id:
                status_code = 201

            return jsonify({'status': 'OK', 'message': 'OK', 'entries': recs, 'count': len(recs)}), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


@app.route('/products/<product_id>/videos/', methods=['GET'])
@app.route('/products/<product_id>/videos/<video_id>/', methods=['GET'])
def product_videos_get(product_id, video_id=None):
    response = spcall('product_videos_get', (video_id, product_id,), )
    if 'Error' in str(response[0][0]):
        return jsonify({'status': 'error', 'message': response[0][0]})

    recs = []
    for r in response:
        recs.append(
            {'product_id': r[0], 'video_id': r[1]})
    return jsonify({'status': 'OK', 'message': 'OK', 'entries': recs, 'count': len(recs)})


@app.route('/products/<product_id>/videos/', methods=['POST'])
@app.route('/products/<product_id>/videos/<video_id>/', methods=['PUT'])
def product_videos_upsert(product_id, video_id=None):
    data = json.loads(request.data)

    if clean_form(data):

        response = spcall('product_videos_upsert', (
            video_id,
            product_id,
            data['video_name'],
            str(data['date_added']),),)

        if video_id and response[0][0] == 'error' and request.method == "PUT":
            raise InvalidRequest('Does not exist', status_code=404)

        if 'Error' in str(response[0][0]):
            return jsonify({'status': 'error', 'message': response[0][0]})

        recs = []
        for r in response:
            recs.append({"video_id": r[0], "product_id": r[1]})

            status_code = 200
            if not video_id:
                status_code = 201

            return jsonify({'status': 'OK', 'message': 'OK', 'entries': recs, 'count': len(recs)}), status_code
    else:
        raise InvalidForm('Some fields have error values', status_code=422)


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

#
# @app.route('/notes/<note_id>/', methods=['DELETE'])
# def notes_delete(note_id=None):
#     response = spcall('notes_delete', (note_id,))
#     if 'Error' in str(response[0][0]):
#         return jsonify({'status': 'error', 'message': response[0][0]})
#     return jsonify({'status': 'OK', 'message': response[0][0]})


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

