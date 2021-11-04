from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from webcontrol.auth import login_required
from webcontrol.db import get_db
bp = Blueprint('showcontrol', __name__)

@bp.route('/showcontrol', methods=('GET', 'POST'))
def showcontrol():
    if request.method == 'POST':
        if "pause" in request.form:
            pause(1,)
        if "resume" in request.form:
            print("resume")
    return render_template('showcontrol/pause.html')
