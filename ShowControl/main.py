from oscpy.client import OSCClient
from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime


def play(reaper: OSCClient):
    reaper.send_message(b'/play', [1])


def main():
    address = "127.0.0.1"
    port = 8000

    reaper = OSCClient(address, port)

    sched = BlockingScheduler()

    exec_time = datetime(2021, 8, 31, 16, 52)

    job = sched.add_job(play, 'date', run_date=exec_time, args=[reaper])
    sched.start()

if __name__ == "__main__":
    main()
