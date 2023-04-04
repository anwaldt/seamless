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
from pathlib import Path

server = OSCThreadServer()


@ServerClass
class SchedControl(object):
    def __init__(self):
        global server

        self.schedule_file = "/etc/seamless/schedule.yml"
        self.config_file = "/etc/seamless/showcontrol_config.yml"
        self.tracks_dir = Path("/etc/seamless/tracks/")

        with open(self.config_file) as f:
            self.config = yaml.load(f, Loader=yaml.FullLoader)

        self.generate_track_list()

        self.video_broadcast_ip = self.config["videobroadcast_ip"]
        self.video_broadcast_port = self.config["videobroadcast_port"]

        self.playing = False

        self.reaper = OSCClient(self.config["reaper_ip"], self.config["reaper_port"])

        server.listen(
            self.config["server_ip"], self.config["server_port"], default=True
        )

        self.sched = BlockingScheduler()
        self.jobs = self.load_show_control()
        self.add_jobs_to_scheduler()

        self.sched_thr = Thread(target=self.sched.start)
        self.sched_thr.start()
        print("sched_control init finished")

    def play(self, track_nr):
        self.reaper.send_message(b"/region", [track_nr])
        # if playing == False:
        self.reaper.send_message(b"/stop", [1.0])
        self.reaper.send_message(b"/play", [1.0])

    def send_udp_broadcast(self, command_dict: dict):
        command_dict.update({"async": True})
        message = json.dumps(command_dict).encode("utf-8") + b"\n"
        print(message)

        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.sendto(message, (self.video_broadcast_ip, self.video_broadcast_port))
        sock.close()

    @server.address_method(b"/play")
    def play_state(self, *values):
        # TODO warum wird das aufgerufen, funktioniert das noch?
        return
        print(values[0])
        if values[0] == 1.0:
            self.playing = True
            try:
                self.send_udp_broadcast({"command": ["set_property", "pause", "no"]})
            except:
                print("sending play command failed")

        elif values[0] == 0.0:
            self.playing = False
            try:
                self.send_udp_broadcast({"command": ["set_property", "pause", "yes"]})
            except:
                print("sending pause command failed")

    @server.address_method(b"/showcontrol/pause")
    def pause(self, *values):
        if 1.0 in values:
            print("Pause message!")
            self.reaper.send_message(b"/track/1/mute", [1])
            # if playing == True:
            time.sleep(0.5)
            self.reaper.send_message(b"/stop", [1.0])
            print("Paused!")

            # Video nr 0 starts with a black screen
            try:
                self.send_udp_broadcast({"command": ["playlist-play-index", 0]})
            except:
                print("sending play video index command to 0 failed")

            self.sched.pause()

        elif 0.0 in values:
            print("Resumed!")
            self.reaper.send_message(b"/track/1/mute", [0])
            self.sched.resume()

    @server.address_method(b"/showcontrol/reboot")
    def reboot(*values):
        if 1.0 in values:
            for machine in self.config["system"]:
                print("Reboot {}".format(machine["name"]))
                os.popen(
                    "systemctl -H {}@{} reboot".format(machine["user"], machine["ip"])
                )

    @server.address_method(b"/showcontrol/track")
    def play_track(self, *values):
        self.sched.pause()
        self.reaper.send_message(b"/track/1/mute", [0])

        if isinstance(values[0], int):
            # TODO maybe play the track at that index instead? would be unpredictable tho...
            print("Play_track argument was of type int, should be string")
            return
        track_id = values[0]
        track = self.tracks[track_id]

        print(
            f"Play track: {track_id} (audio_index {track['audio_index']}, video_index {track['video_index']}"
        )

        self.play(track["audio_index"])
        self.play_video(track["video_index"])

    def play_video(self, video_index):
        try:
            self.send_udp_broadcast({"command": ["playlist-play-index", video_index]})
        except:
            print(f"Sending play video index command to {video_index} failed.")

    def load_show_control(self):
        with open(self.schedule_file) as f:
            data = yaml.load(f, Loader=yaml.FullLoader)
            return data

    def add_jobs_to_scheduler(self):
        for job in self.jobs:
            if job["command"] == "play":
                self.sched.add_job(
                    self.play,
                    "cron",
                    hour=job["hour"],
                    minute=job["minute"],
                    second=job["second"],
                    day_of_week=job["day_of_week"],
                    args=[job["audio_index"]],
                )
            if "video_index" in job:
                self.sched.add_job(
                    self.play_video,
                    "cron",
                    hour=job["hour"],
                    minute=job["minute"],
                    second=job["second"],
                    day_of_week=job["day_of_week"],
                    args=[job["video_index"]],
                )
        self.sched.print_jobs()

    def generate_track_list(self):
        """Reads the tracks directory and stores the tracks into the self.tracks dict

        Raises:
            KeyError: Raised when a track id is not unique
        """
        self.tracks = {}
        for track_file in self.tracks_dir.iterdir():
            with open(track_file) as f:
                track_conf = yaml.load(f, Loader=yaml.FullLoader)

            # check that the track id is unique
            if list(track_conf.keys())[0] in self.tracks:
                raise KeyError(f"Track id {list(track_conf.keys())[0]} is not unique!")

            # Add track to tracks dict
            self.tracks.update(track_conf)

    def get_scheduled_tracks(self, n_tracks=20):
        """Returns the next n_tracks scheduled tracks.

        Args:
            n_tracks (int, optional): Number of tracks to return. Defaults to 15.

        Returns:
            List[Tuple[str]]: Scheduled tracks as list with tuples in the format (time, title)
        """
        # get all jobs
        a = self.sched.get_jobs()

        if len(a) < n_tracks:
            n_tracks = len(a)

        # filter out only play commands
        next_track_jobs = (
            t for t in a[: n_tracks * 2] if t.name == "SchedControl.play"
        )

        # build a readable data structure out of that
        next_tracks = []
        for t in next_track_jobs:
            for track_name, value in self.tracks.items():
                if value["audio_index"] == t.args[0]:
                    next_tracks.append(
                        (t.next_run_time.strftime("%H:%M"), value["title"])
                    )
                    break

        return next_tracks


if __name__ == "__main__":
    sched = SchedControl()
    while True:
        print("playing 4")
        sched.play_track("oksus")
        time.sleep(0.5)
        print("playing 8")
        sched.play_track("trailer")
        time.sleep(0.5)

    sched.pause()
