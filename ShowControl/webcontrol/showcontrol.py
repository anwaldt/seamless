from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort
from threading import Thread

from webcontrol import schedctrl
from webcontrol.auth import login_required
from webcontrol.db import get_db
bp = Blueprint('showcontrol', __name__)

@bp.route('/showcontrol', methods=('GET', 'POST'))
def showcontrol():
    global schedctrl
    if request.method == 'POST':
        if "pause" in request.form:
            t = Thread(target=schedctrl.pause, args=(1,))
            t.start()
        if "resume" in request.form:
            t = Thread(target=schedctrl.pause, args=(0,))
            t.start()
    return render_template('showcontrol/pause.html')
