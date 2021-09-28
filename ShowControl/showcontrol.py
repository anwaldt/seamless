#!/usr/bin/env python3
import time

from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import yaml
import requests
import os
import socket
import json

schedule_file = "/etc/seamless/schedule.yml"
config_file = "/etc/seamless/showcontrol_config.yml"
with open(config_file) as f:
    config = yaml.load(f, Loader=yaml.FullLoader)

videoplayers = []
playing = False

reaper = OSCClient(config['reaper_ip'], config['reaper_port'])
server = OSCThreadServer()

server.listen(config['server_ip'], config['server_port'], default = True)

sched = BlockingScheduler()

def play(track_nr):
    global playing
    reaper.send_message(b'/region', [track_nr])
    # if playing == False:
    reaper.send_message(b'/stop', [1.0])
    reaper.send_message(b'/play', [1.0])


@server.address(b'/play')
def play_state(*values):
    global playing
    print(values[0])
    if values[0] == 1.0:
        playing = True
        for player in videoplayers:
            try:
                sock = socket.socket()
                sock.connect((player['ip'],12345))

                try:
                    message = json.dumps({'command': ['set_property', 'pause', 'no']}).encode('utf-8') + b'\n'
                    print(message)
                    sock.sendall(message)
                    sock.close()
                except:
                    print('Sending play command to {} failed.'.format(player['name']))

            except:
                print('No connection to video player: {}', player['name'])


    elif values[0] == 0.0:
        playing = False
        for player in videoplayers:
            try:
                sock = socket.socket()
                sock.connect((player['ip'],12345))

                try:
                    message = json.dumps({'command': ['set_property', 'pause', 'yes']}).encode('utf-8') + b'\n'
                    print(message)
                    sock.sendall(message)
                    sock.close()
                except:
                    print('Sending pause command to {} failed.'.format(player['name']))

            except:
                print('No connection to video player: {}', player['name'])

@server.address(b'/showcontrol/pause')
def pause(*values):
    global sched, playing
    if 1.0 in values:
        reaper.send_message(b'/track/1/mute', [1])
        # if playing == True:
        time.sleep(0.5)
        reaper.send_message(b'/stop', [1.0])
        # Video nr 1 starts with a black screen
        try:
            requests.get('http://avm:avm@172.25.18.172/index.php?playlist_index=0', timeout=0.001)
        except:
            print('No connection to video player!')
        sched.pause()
        print('Paused!')
    elif 0.0 in values:
        print('Resumed!')
        reaper.send_message(b'/track/1/mute', [0])
        sched.resume()


@server.address(b'/showcontrol/reboot')
def reboot(*values):
    if 1.0 in values:
        for machine in config['system']:
            print('Reboot {}'.format(machine['name']))
            os.popen('systemctl -H {}@{} reboot'.format(machine['user'], machine['ip']))


@server.address(b'/showcontrol/track')
def play_track(*values):
    global sched
    print('Play track: ', values[0])
    sched.pause()
    reaper.send_message(b'/track/1/mute', [0])
    if values[0] == 0:
        play(1)
        play_video(0)
    elif values[0] == 1:
        play(2)
        play_video(1)
    elif values[0] == 2:
        play(3)
        play_video(2)
    elif values[0] == 3:
        play(4)
        play_video(4)


def play_video(video_index):
    for player in videoplayers:
        try:
            sock = socket.socket()
            sock.connect((player['ip'],12345))
            try:
                message = json.dumps({'command': ['playlist-play-index', video_index]}).encode('utf-8') + b'\n'
                print(message)
                sock.sendall(message)
                sock.close()
            except:
                print('Sending play video index command to {} failed.'.format(player['name']))

        except:
            print('No connection to video player: {}', player['name'])



def load_show_control():
    with open(schedule_file) as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        return data


def add_jobs_to_scheduler(jobs, scheduler):
    for job in jobs:
        if job['command'] == 'play':
            scheduler.add_job(play, 'cron', hour=job['hour'], minute=job['minute'], second=job['second'], day_of_week=job['day_of_week'], args=[job['audio_index']])
        if 'video_index' in job:
            scheduler.add_job(play_video, 'cron', hour=job['hour'], minute=job['minute'], second=job['second'], day_of_week=job['day_of_week'], args=[job['video_index']])
    scheduler.print_jobs()


def generate_videoplayer_list():
    global videoplayers
    for machine in config['system']:
        if 'mpv' in machine['services']:
            videoplayers.append(machine)


def main():
    generate_videoplayer_list()
    jobs = load_show_control()
    add_jobs_to_scheduler(jobs, sched)

    sched.start()

if __name__ == "__main__":
    main()
