import functools

from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from webcontrol.db import get_db

bp = Blueprint('auth', __name__, url_prefix='/auth')

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view

def admin_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        db = get_db()
        users = db.execute(
            'SELECT * FROM user'
            ).fetchall()
        if len(users) == 0:
            return view(**kwargs)
        if g.user is None:
            return redirect(url_for('auth.login'))
        if g.user['admin'] == 0:
            return redirect(url_for('index'))

        return view(**kwargs)

    return wrapped_view

@bp.route('/')
def index():
    db = get_db()
    users = db.execute(
        'SELECT id, username, admin'
        ' FROM user'
    ).fetchall()
    return render_template('auth/users.html', users=users)

@bp.route('/register', methods=('GET', 'POST'))
@admin_required
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        admin = (request.form.get('admin') == 'on')
        db = get_db()
        error = None

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'

        if error is None:
            try:
                db.execute(
                    "INSERT INTO user (username, password, admin) VALUES (?, ?, ?)",
                    (username, generate_password_hash(password), int(admin))
                )
                db.commit()
            except db.IntegrityError:
                error = f"User {username} is already registered."
            else:
                return redirect(url_for("auth.index"))

        flash(error)

    return render_template('auth/register.html')

@bp.route('/change_password', methods=('GET', 'POST'))
@login_required
def change_password():
    if request.method == 'POST':
        username = request.form['username']
        old_password = request.form['old_password']
        new_password = request.form['new_password']
        db = get_db()
        error = None

        if not username:
            error = 'Username is required.'
        elif not old_password:
            error = 'Old password is required.'
        elif not new_password:
            error = 'New password is required.'

        if not check_password_hash(user['password'], old_password):
            error = 'Incorrect password.'

        if error is None:
            try:
                db.execute(
                    "UPDATE user SET password = ? WHERE username = ?;",
                    (generate_password_hash(new_password), username)
                )
                db.commit()
            except db.IntegrityError:
                error = f"User {username} is already registered."
            else:
                return redirect(url_for("auth.login"))

        flash(error)

    return render_template('auth/change_password.html')

@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        db = get_db()
        error = None
        user = db.execute(
            'SELECT * FROM user WHERE username = ?', (username,)
        ).fetchone()

        if user is None:
            error = 'Incorrect username.'
        elif not check_password_hash(user['password'], password):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['user_id'] = user['id']
            return redirect(url_for('index'))

        flash(error)

    return render_template('auth/login.html')

@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        g.user = get_db().execute(
            'SELECT * FROM user WHERE id = ?', (user_id,)
        ).fetchone()

@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

# def get_user(id, check_user=True):
#     user = get_db().execute(
#         'SELECT id, username'
#         ' FROM user WHERE id = ?',
#         (id,)
#     ).fetchone()

#     if post is None:
#         abort(404, f"User id {id} doesn't exist.")

#     return post

@bp.route('/<int:id>/delete', methods=('POST',))
@login_required
def delete(id):
    # get_user(id)
    db = get_db()
    db.execute('DELETE FROM user WHERE id = ?', (id,))
    db.commit()
    return redirect(url_for('auth.index'))
