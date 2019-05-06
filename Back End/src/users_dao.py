from db import Users, db

def get_user_by_email(email):
    return Users.query.filter(Users.email == email).first()

def get_user_by_session_token(session_token):
    return Users.query.filter(Users.session_token == session_token).first()

def get_user_by_update_token(update_token):
    return Users.query.filter(Users.update_token == update_token).first()

def verify_credentials(email, password):
    optional_user = get_user_by_email(email)

    if optional_user is None:
        return False, None

    return optional_user.verify_password(password), optional_user

def create_user(email, password):
    optional_user = get_user_by_email(email)

    if optional_user is not None:
        return False, optional_user

    user = Users(
        email=email,
        password=password
    )

    db.session.add(user)
    db.session.commit()
    return True, user

def renew_session(update_token):
    user = get_user_by_update_token(update_token)
    print(user)
    if user is None:
        raise Exception('Invalid update token')

    user.renew_session()
    db.session.commit()
    return user
