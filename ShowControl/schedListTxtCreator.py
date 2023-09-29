"""
Reads the show control schedule.yml -file and the defined blocks/tracks
and creates a readable list with time and title.

"""

import yaml
import argparse
import glob
import os
from pathlib import Path
from common import read_tracks


day_names = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
base_path = Path(__file__).parent


def create_alternative_schedule(input_file, output_file, tracks_folder):
    tracks = read_tracks(tracks_folder, identifier_is_name=False)
    with open(input_file, "r") as f:
        schedule = yaml.safe_load(f)

    # prepare track dicts by adding empty runtime dicts
    for t in tracks.values():
        t["runtimes"] = {}

    # populate runtime dicts by adding all occurances from the schedule file to them
    for e in schedule:
        idx = e["audio_index"]
        day_of_week = e["day_of_week"]
        time = f"{e['hour']:02}:{e['minute']:02}"

        if day_of_week not in tracks[idx]["runtimes"]:
            tracks[idx]["runtimes"][day_of_week] = []
        tracks[idx]["runtimes"][day_of_week].append(time)

    # write schedule to file
    with open(output_file, "w") as f:
        for t in tracks.values():
            # write track title
            f.write(t["title"] + "\n")

            for day_nrs, times in t["runtimes"].items():
                # convert day_nrs to human readable format
                if isinstance(day_nrs, str):
                    day_nrs = day_nrs.split(",")
                    days = ",".join([day_names[int(d)] for d in day_nrs])
                else:
                    days = day_names[day_nrs]

                playtimes = ", ".join(times)
                f.write(f"\t{days:<20}\t{playtimes}\n")
            f.write("\n")


def create_readable_txt(input_file, output_file, tracks_folder):
    track_dict = read_tracks(tracks_folder)
    with open(input_file, "r") as f:
        schDict = yaml.safe_load(f)

    # make sure output file is not a directory, append .txt to the output filename if it has no file ending
    if os.path.isdir(output_file):
        output_file = os.path.join(output_file, "schedule_readable.txt")
    else:
        fn, fe = os.path.splitext(output_file)
        if not fe:
            output_file = output_file + ".txt"

    with open(output_file, "w") as outfile:
        for b in schDict:
            # convert day numbers to names
            # if there is only one day, it is already an integer
            day_nrs = b["day_of_week"]
            if isinstance(day_nrs, str):
                day_nrs = day_nrs.split(",")
                days = ",".join([day_names[int(d)] for d in day_nrs])
            else:
                days = day_names[day_nrs]

            timestr = f"{b['hour']:02}:{b['minute']:02}:{b['second']:02}"

            idx = b["audio_index"]
            if idx in track_dict:
                track_title = track_dict[idx]["title"]
                outfile.write(f"{days:<20}\t{timestr}\t{track_title}\n")
            else:
                outfile.write(timestr + "\n")
    outfile.close()
    print("Program Schedule points", len(schDict))
    print("written programfile to", output_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser("Convert yaml file to readable program file .txt")
    parser.add_argument(
        "-i",
        "--inputfile",
        default=base_path.parent / "Configs/HUFO/schedule.yml",
        type=str,
        help="schedule yml file to convert",
    )
    parser.add_argument(
        "-o",
        "--outputfile",
        default=base_path / "schedule_readable.txt",
        type=str,
        help="output file path or folder path for txt",
    )
    parser.add_argument(
        "-t",
        "--tracksfolder",
        type=str,
        default=base_path.parent / "Configs/HUFO/tracks",
        help="folder of the defined tracks/blocks",
    )
    args = parser.parse_args()

    blockpath = args.tracksfolder
    outputfilepath = args.outputfile
    inputfilepath = args.inputfile

    create_alternative_schedule(inputfilepath, outputfilepath, blockpath)
