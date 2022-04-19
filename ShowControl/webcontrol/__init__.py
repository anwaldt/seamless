import os

from flask import Flask
from schedcontrol import SchedControl
from xdg import (xdg_state_home)

schedctrl = SchedControl()

def create_app(test_config=None):
    # create and configure the app
    app = Flask(
        __name__,
        instance_path=os.path.join(xdg_state_home(),'showcontrol'),
        instance_relative_config=True
    )
    app.config.from_mapping(
        SECRET_KEY='dev',
        # SERVER_NAME='127.0.0.1:8080',
        DATABASE=os.path.join(app.instance_path, 'webcontrol.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        return 'Hello, World!'

    from . import db
    db.init_app(app)
#    if not os.path.isfile(os.path.join(app.instance_path, 'webcontrol.sqlite')):
#        db.init_db()

    from . import auth
    app.register_blueprint(auth.bp)

    from . import showcontrol
    app.register_blueprint(showcontrol.bp)
    app.add_url_rule('/', endpoint='index')
    app.add_url_rule('/tracks', endpoint='tracks')
    return app
