from oscpy.client import OSCClient
from apscheduler.schedulers.background import BackgroundScheduler
from datetime import datetime

def play(reaper: OSCClient):
    reaper.send_message(b'/play', [1])

def main():
    address = "127.0.0.1"
    port = 8000

    reaper = OSCClient(address, port)
    play(reaper)

    sched = BackgroundScheduler()

    exec_time = datetime(2021, 8, 31, 15, 21)

    job = sched.add_date_job(play, exec_time, reaper)
    sched.start()

if __name__ == "__main__":
    main()
