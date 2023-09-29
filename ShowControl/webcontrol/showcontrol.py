from flask import Blueprint, flash, g, redirect, render_template, request, url_for
from werkzeug.exceptions import abort
from threading import Thread

import apscheduler
from webcontrol import schedctrl
from webcontrol.auth import login_required
from webcontrol.db import get_db

bp = Blueprint("showcontrol", __name__)


@bp.route("/", methods=("GET", "POST"))
@login_required
def showcontrol():
    global schedctrl
    if request.method == "POST":
        if "pause" in request.form:
            t = Thread(target=schedctrl.pause, args=(1,))
            t.start()
        if "resume" in request.form:
            t = Thread(target=schedctrl.pause, args=(0,))
            t.start()
    print(
        "Scheduler is running: ",
        schedctrl.sched.state != apscheduler.schedulers.base.STATE_PAUSED,
    )
    return render_template(
        "showcontrol/pause.html",
        state=(schedctrl.sched.state == apscheduler.schedulers.base.STATE_PAUSED),
        schedule=schedctrl.get_scheduled_tracks(),
    )


@bp.route("/tracks", methods=("GET", "POST"))
@login_required
def web_tracks():
    global schedctrl
    if request.method == "POST":
        track = request.form.get("track")

        if track not in schedctrl.tracks:
            return "Track not found", 400

        schedctrl.play_track(track)

    # Sort track keys by audio index
    sorted_track_keys = sorted(
        schedctrl.tracks.keys(), key=lambda x: schedctrl.tracks[x]["audio_index"]
    )
    # passing keys as a list is needed in the rendering to specify an order of the tracks
    return render_template(
        "showcontrol/tracks.html", tracks=schedctrl.tracks, track_keys=sorted_track_keys
    )
