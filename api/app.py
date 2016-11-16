#!flask/bin/python
import flask
from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    return "Hello, World!"


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


@app.route('/api/addsellers/', methods=['POST'])
def add_seller():
    jsn = json.loads(request.data)

    if invalid(jsn['email']):
        return jsonify({'status': 'Error', 'message': 'Invalid Email'})

    res = spcall("addseller", (
        jsn['first_name'],
        jsn['middle_name'],
        jsn['last_name'],
        jsn['email'],
        jsn['age'],
        jsn['contact_number'],
        jsn['address']), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})

@app.route('/api/sellers/<seller_id>/', methods=['GET'])
def getseller(seller_id):
    res = spcall('getseller_id', [seller_id])

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'Error', 'message': res[0][0]})
    rec = res[0]

    return jsonify({"seller_id": str(seller_id), "first_name": str(rec[0]), "middle_name": str(rec[1]), "last_name": str(rec[2]),
                    "email": str(rec[3]), "age": str(rec[4]), "contact_number": str(rec[5]), "address": str(rec[6])})

@app.route('/api/sellers/', methods=['GET'])
def get_all_sellers():
    res = spcall('getsellers', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'Error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"seller_id": str(r[0]), "first_name": str(r[1]), "middle_name": str(r[2]), "last_name": str(r[3]),
                    "email": str(r[4]), "age": str(r[5]), "contact_number": str(r[6]), "address": str(r[7])})

    return jsonify({'status': 'OK', 'entries': recs, 'count': len(recs)})

@app.route('/api/sellers/<seller_id/', methods=['PUT'])
def update_seller():
    jsn = json.loads(request.data)


    seller_id = jsn.get('seller_id', '')
    first_name = jsn.get('first_name', '')
    middle_name = jsn.get('middle_name', '')
    last_name = jsn.get('last_name', '')
    email = jsn.get('email', '')
    age = jsn.get('age', '')
    contact_number = jsn.get('contact_number', '')
    address = jsn.get('address', '')

    spcall('updateseller', (
        seller_id,
        first_name,
        middle_name,
        last_name,
        email,
        age,
        contact_number,
        address
        ), True)

    return jsonify({'status': 'success'})