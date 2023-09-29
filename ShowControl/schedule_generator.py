import yaml
import os
from datetime import datetime, timedelta, time
from pathlib import Path
import logging
from schedListTxtCreator import create_readable_txt, create_alternative_schedule
from common import read_blocks, read_tracks

log = logging.getLogger()

day_numbers = {
    "monday": 0,
    "tuesday": 1,
    "wednesday": 2,
    "thursday": 3,
    "friday": 4,
    "saturday": 5,
    "sunday": 6,
}

path_config = Path(__file__).parent.parent / "Configs/HUFO"
time_start = datetime(2022, 2, 1, 10, 40, 0)
time_stop = datetime(2022, 2, 1, 18, 30, 0)

output_file = path_config / "schedule.yml"


def writeEntry(
    file, hour, minute, secs, audio_idx, video_idx, days=[0, 1, 2, 3, 4, 5, 6]
):
    days = [str(d) for d in days]
    file.write(
        f"- audio_index: {audio_idx}\n"
        f"  command: play\n"
        f"  day_of_week: {','.join(days)}\n"
        f"  hour: {hour}\n"
        f"  minute: {minute}\n"
        f"  second: {secs}\n"
        f"  video_index: {video_idx}\n"
    )


def round_up_time(timestamp: datetime, round_to_minutes=5):
    delta = timedelta(minutes=round_to_minutes)
    return timestamp + (datetime.min - timestamp) % delta


def main():
    # load tracks
    tracks = read_tracks(path_config / "tracks")
    print(tracks)
    # load blocks
    blocks = read_blocks(path_config / "blocks")

    # load block plan
    with open(path_config / "blockplan.yml") as f:
        blockplan = yaml.load(f, Loader=yaml.FullLoader)

    # find days with explicit schedules
    days_explicit_schedule = set(blockplan.keys()) - set(["default"])

    # get the differnce of the set of all day numbers and the days with an
    # explicit schedule to find the days for which the
    # default schedule will be applied
    days_default_schedule = set(day_numbers.keys()) - days_explicit_schedule
    day_numbers_default = [day_numbers[d] for d in days_default_schedule]
    day_numbers_default.sort()
    with open(output_file, "w") as out_file:
        # iterate over all days (including "default")
        for day in blockplan:
            logging.info(f"building schedule for day {day}")
            day_over = False

            # get the daynumbers for the default block plan
            if day == "default":
                days = day_numbers_default
                logging.info(
                    f"default schedule on days {', '.join(days_default_schedule)}"
                )
            else:
                days = [day_numbers[day]]

            blockstart = time_start

            # iterate over all blocks on a certain day
            for blockname in blockplan[day]["blocks"]:
                block = blocks[blockname]

                trackstart = blockstart

                if day_over:
                    break

                # iterate over all tracks in a block
                for track_name in block["tracks"]:
                    if trackstart >= time_stop:
                        day_over = True
                        break

                    audio_idx = tracks[track_name]["audio_index"]
                    video_idx = tracks[track_name]["video_index"]
                    track_minutes = tracks[track_name]["duration"]["minutes"]
                    track_seconds = tracks[track_name]["duration"]["seconds"]

                    writeEntry(
                        out_file,
                        trackstart.hour,
                        trackstart.minute,
                        trackstart.second,
                        audio_idx,
                        video_idx,
                        days,
                    )

                    trackstart = round_up_time(
                        trackstart
                        + timedelta(minutes=track_minutes, seconds=track_seconds)
                        + timedelta(seconds=block["track_padding"])
                    )
                # blockstart = blockstart + timedelta(minutes=block["length"])
                blockstart = trackstart
                # if blockstart <= trackstart:
                # log.warn("Block length is too short")


if __name__ == "__main__":
    main()
    today = datetime.now().strftime("%Y-%m-%d")
    readable_schedule_path = Path(__file__).parent / "readable_schedules"
    create_readable_txt(
        output_file,
        readable_schedule_path / f"hufoprogram_{today}_full_schedule.txt",
        path_config / "tracks",
    )
    create_alternative_schedule(
        output_file,
        readable_schedule_path / f"hufoprogram_{today}_track_schedule.txt",
        path_config / "tracks",
    )
