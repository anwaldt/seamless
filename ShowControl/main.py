from oscpy.client import OSCClient
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import yaml

address = "127.0.0.1"
port = 8000

reaper = OSCClient(address, port)

def play(track_nr):
    reaper.send_message(b'/region', [track_nr])

def load_show_control():
    with open('example.yml') as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        return data

def add_jobs_to_scheduler(jobs, scheduler):
    for job in jobs:
        if job['command'] == 'play':
            scheduler.add_job(play, 'date', run_date=job['time'], args=[job['nr']])

def main():
    sched = BlockingScheduler()

    jobs = load_show_control()
    add_jobs_to_scheduler(jobs, sched)

    sched.start()

if __name__ == "__main__":
    main()
