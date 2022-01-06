#!/usr/bin/env python3

import yaml

schedule_file = "schedule_old.yml"

with open(schedule_file) as f:
    data = yaml.load(f, Loader=yaml.FullLoader)
    for job in data:
    	job['video_index'] += 5
    f.close()

    with open("schedule_new.yml", "w") as f2:
        yaml.dump(data, f2)
        f2.close()
