from oscpy.client import OSCClient
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import yaml

address = "127.0.0.1"
port = 8000

reaper = OSCClient(address, port)

def play(reaper: OSCClient):
    reaper.send_message(b'/play', [1])

def load_show_control():
    with open('example.yml') as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        return data

def add_jobs_to_scheduler(jobs, scheduler):
    for job in jobs:
        scheduler.add_job(play, 'date', run_date=job['time'], args=[reaper])

def main():
    sched = BlockingScheduler()

    jobs = load_show_control()
    add_jobs_to_scheduler(jobs, sched)

    sched.start()

if __name__ == "__main__":
    main()
