from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer, ServerClass
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
from threading import Thread
import yaml
import requests
import os
import socket
import json
import time

server = OSCThreadServer()
server.listen(default=True)

@ServerClass
class SchedControl(object):

    def __init__(self):
        self.schedule_file = "/etc/seamless/schedule.yml"
        self.config_file = "/etc/seamless/showcontrol_config.yml"
        with open(self.config_file) as f:
            self.config = yaml.load(f, Loader=yaml.FullLoader)

        self.videoplayers = []
        self.generate_videoplayer_list()
        self.playing = False

        self.reaper = OSCClient(self.config['reaper_ip'], self.config['reaper_port'])
        server = OSCThreadServer()

        server.listen(self.config['server_ip'], self.config['server_port'], default = True)

        self.sched = BlockingScheduler()
        self.jobs = self.load_show_control()
        self.add_jobs_to_scheduler()

        self.sched_thr = Thread(target=self.sched.start)

    def play(self, track_nr):
        self.reaper.send_message(b'/region', [track_nr])
        # if playing == False:
        self.reaper.send_message(b'/stop', [1.0])
        self.reaper.send_message(b'/play', [1.0])


    @server.address_method(b'/play')
    def play_state(self, *values):
        print(values[0])
        if values[0] == 1.0:
            self.playing = True
            for player in self.videoplayers:
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
            self.playing = False
            for player in self.videoplayers:
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

    @server.address_method(b'/showcontrol/pause')
    def pause(*values):
        if 1.0 in values:
            self.reaper.send_message(b'/track/1/mute', [1])
            # if playing == True:
            time.sleep(0.5)
            self.reaper.send_message(b'/stop', [1.0])
            # Video nr 1 starts with a black screen
            for player in self.videoplayers:
                try:
                    sock = socket.socket()
                    sock.connect((player['ip'],12345))
                    try:
                        message = json.dumps({'command': ['playlist-play-index', 0]}).encode('utf-8') + b'\n'
                        print(message)
                        sock.sendall(message)
                        sock.close()
                    except:
                        print('Sending play video index command to {} failed.'.format(player['name']))

                except:
                    print('No connection to video player: {}', player['name'])

            self.sched.pause()
            print('Paused!')
        elif 0.0 in values:
            print('Resumed!')
            self.reaper.send_message(b'/track/1/mute', [0])
            self.sched.resume()


    @server.address_method(b'/showcontrol/reboot')
    def reboot(*values):
        if 1.0 in values:
            for machine in self.config['system']:
                print('Reboot {}'.format(machine['name']))
                os.popen('systemctl -H {}@{} reboot'.format(machine['user'], machine['ip']))


    @server.address_method(b'/showcontrol/track')
    def play_track(self, *values):
        print('Play track: ', values[0])
        self.sched.pause()
        self.reaper.send_message(b'/track/1/mute', [0])
        if values[0] == 0:
            self.play(1)
            self.play_video(0)
        elif values[0] == 1:
            self.play(2)
            self.play_video(1)
        elif values[0] == 2:
            self.play(3)
            self.play_video(2)
        elif values[0] == 3:
            self.play(4)
            self.play_video(4)


    def play_video(self, video_index):
        for player in self.videoplayers:
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



    def load_show_control(self):
        with open(self.schedule_file) as f:
            data = yaml.load(f, Loader=yaml.FullLoader)
            return data


    def add_jobs_to_scheduler(self):
        for job in self.jobs:
            if job['command'] == 'play':
                self.sched.add_job(self.play, 'cron', hour=job['hour'], minute=job['minute'], second=job['second'], day_of_week=job['day_of_week'], args=[job['audio_index']])
            if 'video_index' in job:
                self.sched.add_job(self.play_video, 'cron', hour=job['hour'], minute=job['minute'], second=job['second'], day_of_week=job['day_of_week'], args=[job['video_index']])
        self.sched.print_jobs()


    def generate_videoplayer_list(self):
        for machine in self.config['system']:
            if 'mpv' in machine['services']:
                self.videoplayers.append(machine)
