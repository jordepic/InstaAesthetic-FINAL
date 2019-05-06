from flask_sqlalchemy import SQLAlchemy
import bcrypt
import datetime
import hashlib
import os

db = SQLAlchemy()

class Users(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String, nullable = False, unique = True)
    password_hashed = db.Column(db.String, nullable = False)

    #SESSION INFORMATION
    session_token = db.Column(db.String, nullable = False, unique = True)
    session_expiration = db.Column(db.DateTime, nullable = False)
    update_token = db.Column(db.String, nullable = False, unique = True)
    accounts = db.relationship('Accounts', cascade = 'delete')

    def __init__(self, **kwargs):
        self.email = kwargs.get('email')
        self.password_hashed = bcrypt.hashpw(kwargs.get('password').encode('utf8'),
                                    bcrypt.gensalt(rounds = 13))
        self.renew_session()
        self.accounts = []

    def serialize(self):
        accounts = []
        for account in self.accounts:
            accounts.append(
                {
                   'id': account.id,
                   'name': account.name
                }
            )
        return {
            'id': self.id,
            'email': self.email,
            'accounts': accounts,
        }
    
    def renew_session(self):
        #Generate a random token
        self.session_token = hashlib.sha1(os.urandom(64)).hexdigest()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days = 1)
        self.update_token = self._urlsafe_base_64()

    def _urlsafe_base_64(self):
        return hashlib.sha1(os.urandom(64)).hexdigest()


    def verify_password(self, password):
        return bcrypt.checkpw(password.encode('utf8'), self.password_hashed)

    def verify_session_token(self, session_token):
        return session_token == self.session_token and \
            datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        return update_token == self.update_token

class Accounts(db.Model):
    __tablename__ = 'accounts'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable = False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable = False)

    def __init__(self, **kwargs):
        self.name = kwargs.get('name', '')
        self.user_id = kwargs.get('user_id', '')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name
            }
        
