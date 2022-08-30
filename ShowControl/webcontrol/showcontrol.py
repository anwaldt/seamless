from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort
from threading import Thread

import apscheduler
from webcontrol import schedctrl
from webcontrol.auth import login_required
from webcontrol.db import get_db
bp = Blueprint('showcontrol', __name__)

@bp.route('/', methods=('GET', 'POST'))
@login_required
def showcontrol():
    global schedctrl
    if request.method == 'POST':
        if "pause" in request.form:
            t = Thread(target=schedctrl.pause, args=(1,))
            t.start()
        if "resume" in request.form:
            t = Thread(target=schedctrl.pause, args=(0,))
            t.start()
    print("Scheduler is running: ", schedctrl.sched.state != apscheduler.schedulers.base.STATE_PAUSED)
    return render_template('showcontrol/pause.html', state=(schedctrl.sched.state == apscheduler.schedulers.base.STATE_PAUSED))

@bp.route('/tracks', methods=('GET', 'POST'))
@login_required
def web_tracks():
    global schedctrl
    if request.method == 'POST':
        if "trailer" in request.form:
            schedctrl.play_track((0))
        elif "brunnen" in request.form:
            schedctrl.play_track((1))
        elif "sufi" in request.form:
            schedctrl.play_track((2))
        elif "oksus" in request.form:
            schedctrl.play_track((3))
        elif "datenerhebung" in request.form:
            schedctrl.play_track((4))
        elif "iwillnotweep" in request.form:
            schedctrl.play_track((5))
        elif "liquidcontinent" in request.form:
            schedctrl.play_track((6))
        elif "doublefeedback" in request.form:
            schedctrl.play_track((7))
        elif "thepassage" in request.form:
            schedctrl.play_track((8))
    return render_template('showcontrol/tracks.html')
