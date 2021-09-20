#!/usr/bin/env python3

from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import yaml
import requests
import os

schedule_file = "/etc/seamless/schedule.yml"
config_file = "/etc/seamless/showcontrol_config.yml"
with open(config_file) as f:
    config = yaml.load(f, Loader=yaml.FullLoader)

playing = False

reaper = OSCClient(config['reaper_ip'], config['reaper_port'])
server = OSCThreadServer()

server.listen(config['server_ip'], config['server_port'], default = True)

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


@server.address(b'/mute')
def mute(*values):
    if 1.0 in values:
        reaper.send_message(b'/track/1/mute', [1])
    elif 0.0 in values:
        reaper.send_message(b'/track/1/mute', [0])


@server.address(b'/reboot')
def reboot(*values):
    if 1.0 in values:
        for machine in config['system']:
            print('Reboot {}'.format(machine['name']))
            os.popen('systemctl -H {}@{} reboot'.format(machine['user'], machine['ip']))


def play_video(video_index):
    requests.get('http://avm:avm@172.25.18.172/index.php?playlist_index={}'.format(video_index))


def load_show_control():
    with open(schedule_file) as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        return data


def add_jobs_to_scheduler(jobs, scheduler):
    for job in jobs:
        if job['command'] == 'play':
            scheduler.add_job(play, 'cron', start_date=job['time'], day_of_week=job['day_of_week'], args=[job['audio_index']])
        if 'video_index' in job:
            scheduler.add_job(play_video, 'cron', start_date=job['time'], day_of_week=job['day_of_week'], args=[job['video_index']])


def main():
    sched = BlockingScheduler()

    jobs = load_show_control()
    add_jobs_to_scheduler(jobs, sched)

    sched.start()

if __name__ == "__main__":
    main()
