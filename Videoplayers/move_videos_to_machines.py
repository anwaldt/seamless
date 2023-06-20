import subprocess
from prepare_videos import output_path

video_machines = ["172.25.18.181", "172.25.18.184"]

for machine in video_machines:
    # um writeable zu machen entweder auf webinterface oder "cardmount rw", danach "cardmount ro"
    subprocess.Popen(
        f"scp {output_path}/info_*.mp4 root@{machine}:/mnt/data", shell=True
    ).wait()
    subprocess.Popen(f"ssh {machine} reboot")  # kp ob das klappt
