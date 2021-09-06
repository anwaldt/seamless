from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import yaml
import requests

playing = False
address = "127.0.0.1"
reaper_port = 8000
server_port = 9000

reaper = OSCClient(address, reaper_port)
server = OSCThreadServer()
server.listen(address, server_port, default = True)

def play(track_nr):
    reaper.send_message(b'/region', [track_nr])
    if playing == False:
        reaper.send_message(b'/play', [1])

@server.address(b'/play')
def play_state(*values):
    if 1.0 in values:
        playing = True
        requests.get('http://avm:avm@172.25.18.172/index.php?play')
    elif 0.0 in values:
        playing = False
        requests.get('http://avm:avm@172.25.18.172/index.php?pause')

def play_video(video_index):
    requests.get('http://avm:avm@172.25.18.172/index.php?playlist_index={}'.format(video_index))

def load_show_control():
    with open('example.yml') as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        return data

def add_jobs_to_scheduler(jobs, scheduler):
    for job in jobs:
        if job['command'] == 'play':
            scheduler.add_job(play, 'date', run_date=job['time'], args=[job['nr']])
        if 'video_index' in job:
            scheduler.add_job(play_video, 'date', run_date=job['time'], args=[job['video_index']])


def main():
    sched = BlockingScheduler()

    jobs = load_show_control()
    add_jobs_to_scheduler(jobs, sched)

    sched.start()

if __name__ == "__main__":
    main()
