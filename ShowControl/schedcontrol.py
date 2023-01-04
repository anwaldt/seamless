from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer, ServerClass
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
from threading import Thread
import yaml
import os
import socket
import json
import time

server = OSCThreadServer()

@ServerClass
class SchedControl(object):

    def __init__(self):
        global server

        self.schedule_file = "/etc/seamless/schedule.yml"
        self.config_file = "/etc/seamless/showcontrol_config.yml"

        with open(self.config_file) as f:
            self.config = yaml.load(f, Loader=yaml.FullLoader)


        self.video_broadcast_ip = self.config["videobroadcast_ip"]
        self.video_broadcast_port = self.config["videobroadcast_port"]

        self.playing = False

        self.reaper = OSCClient(self.config['reaper_ip'], self.config['reaper_port'])

        server.listen(self.config['server_ip'], self.config['server_port'], default = True)

        self.sched = BlockingScheduler()
        self.jobs = self.load_show_control()
        self.add_jobs_to_scheduler()

        self.sched_thr = Thread(target=self.sched.start)
        self.sched_thr.start()
        print('sched_control init finished')


    def play(self, track_nr):
        self.reaper.send_message(b'/region', [track_nr])
        # if playing == False:
        self.reaper.send_message(b'/stop', [1.0])
        self.reaper.send_message(b'/play', [1.0])


    def send_udp_broadcast(self, command_dict: dict):
        message = json.dumps(command_dict).encode("utf-8") + b"\n"
        print(message)

        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.sendto(message, (self.video_broadcast_ip, self.video_broadcast_port))
        sock.close()


    @server.address_method(b'/play')
    def play_state(self, *values):
        print(values[0])
        if values[0] == 1.0:
            self.playing = True
            try:
                self.send_udp_broadcast({'command': ['set_property', 'pause', 'no']})
            except:
                print("sending play command failed")

        elif values[0] == 0.0:
            self.playing = False
            try:
                self.send_udp_broadcast({'command': ['set_property', 'pause', 'yes']})
            except:
                print("sending pause command failed")


    @server.address_method(b'/showcontrol/pause')
    def pause(self, *values):
        if 1.0 in values:
            print('Pause message!')
            self.reaper.send_message(b'/track/1/mute', [1])
            # if playing == True:
            time.sleep(0.5)
            self.reaper.send_message(b'/stop', [1.0])
            print('Paused!')

            # Video nr 0 starts with a black screen
            try:
                self.send_udp_broadcast({'command': ['playlist-play-index', 0]})
            except:
                print("sending play video index command to 0 failed")

            self.sched.pause()

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
        
        # Trailer
        if values[0] == 0:
            self.play(1)
            self.play_video(0)
        
        # Brunnen
        elif values[0] == 1:
            self.play(2)
            self.play_video(1)
        
        # Sufi
        elif values[0] == 2:
            self.play(3)
            self.play_video(2)
        
        # Oksus
        elif values[0] == 3:
            self.play(4)
            self.play_video(6)
        
        # Datenerhebung
        elif values[0] == 4:
            self.play(5)
            self.play_video(3)
        
        # I will not weep
        elif values[0] == 5:
            self.play(6)
            self.play_video(4)
        
        # Liquid Continent
        elif values[0] == 6:
            self.play(7)
            self.play_video(7)

        # Double Feedback
        elif values[0] == 7:
            self.play(8)
            self.play_video(9)

        # The Passage
        elif values[0] == 8:
            self.play(9)
            self.play_video(8)


    def play_video(self, video_index):
        try:
            self.send_udp_broadcast({'command': ['playlist-play-index', video_index]})
        except:
            print(f'Sending play video index command to {video_index} failed.')


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

if __name__=="__main__":
    schedctrl = SchedControl()
    schedctrl.play_video(1)
    time.sleep(0.3)
    