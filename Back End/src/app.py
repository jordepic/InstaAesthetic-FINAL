import json
from flask import Flask, request
from db import db, Users, Accounts
import crawler
import users_dao

app = Flask(__name__)

db_filename = 'users.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()

def extract_token(request):
    auth_header = request.headers.get('Authorization')
    if auth_header is None:
        return False, json.dumps({'error': 'Missing authorization header.'})

    bearer_token = auth_header.replace('Bearer ', '').strip()
    if not bearer_token:
        return False, json.dumps({'error': 'Invalid authorization header.'})

    return True, bearer_token

@app.route('/api/register/', methods=['POST'])
def register_account():
    post_body = json.loads(request.data)
    email = post_body.get('email')
    password = post_body.get('password')

    if email is None or password is None:
        return json.dumps({'error': 'Invalid email or password'})

    created, user = users_dao.create_user(email, password)

    if not created:
        return json.dumps({'error': 'User already exists'})

    return json.dumps({
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token
    })

@app.route('/api/login/', methods=['POST'])
def login():
    post_body = json.loads(request.data)
    email = post_body.get('email')
    password = post_body.get('password')

    if email is None or password is None:
        return json.dumps({'error': 'Invalid email or password'})

    success, user = users_dao.verify_credentials(email, password)

    if not success:
        return json.dumps({'error': 'Incorrect email or password'})

    return json.dumps({
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token
    })

@app.route('/api/session/', methods=['POST'])
def update_session():
    success, update_token = extract_token(request)

    if not success:
        return update_token

    try:
        user = users_dao.renew_session(update_token)
    except:
        return json.dumps({'error': 'Invalid update token'})

    return json.dumps({
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token
    })

@app.route('/api/colors/<string:instaAccountName>/')
def get_colors(instaAccountName):
    info = crawler.return_reults(instaAccountName)
    if info == []:
        return json.dumps({'success': False, 'data': 'Not found'})
    else:
        return json.dumps({'success': True, 'data': info})

@app.route('/api/users/')
def get_current_user():
    success, session_token = extract_token(request)

    if not success:
        return session_token   

    user = users_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return json.dumps({'error': 'Invalid session token'})
    else:
        return json.dumps({'success': True, 'data': user.serialize()})

@app.route('/api/users/', methods = ['POST'])
def add_account_to_user():
    success, session_token = extract_token(request)

    if not success:
        return session_token

    user = users_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return json.dumps({'error': 'Invalid session token'})

    post_body = json.loads(request.data)
    one_account = Accounts(
        name = post_body.get('name'),
        user_id = user.id
    )
    
    db.session.add(one_account)
    db.session.commit()
    return json.dumps({'success':True, 'data':one_account.serialize()})

@app.route('/api/users/<string:account_name>/', methods = ['DELETE'])
def delete_account_from_user(account_name):
    success, session_token = extract_token(request)

    if not success:
        return session_token

    user = users_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return json.dumps({'error': 'Invalid session token'})

    try:
        results = Accounts.query.filter(Accounts.user_id == user.id, Accounts.name == account_name).first()
    except:
        results = None

    if user == None or results == None:
        return json.dumps({'success': False, 'data': 'Not found'}), 404
    else:
        db.session.delete(results)
        db.session.commit()
        return json.dumps({'success': True, 'data': results.serialize()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
