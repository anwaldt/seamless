"""
Reads the show control schedule.yml -file and the defined blocks/tracks
and creates a readable list with time and title.

"""

import yaml
import argparse
import glob
import os
from pathlib import Path

day_names = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"]
base_path = Path(__file__).parent

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


blockDict = dict()  # Audioindices to block
blockpath = args.tracksfolder
outputfilepath = args.outputfile
inputfilepath = args.inputfile


tracklist = []
for ymlfile in glob.glob(os.path.join(blockpath, "*.yml")):
    with open(os.path.join(os.getcwd(), ymlfile), "r") as ymlf:
        block: dict = yaml.safe_load(ymlf)
        if type(block) == dict:
            for v in block.values():
                if "title" in v.keys():
                    blockDict[v["title"]] = v
                    tracklist.append(v["title"])
                if "audio_index" in v.keys():
                    # trackcounter = trackcounter + 1
                    blockDict[v["audio_index"]] = v

print("found tacks:", len(tracklist), tracklist)

with open(inputfilepath, "r") as f:
    schDict = yaml.safe_load(f)

# make sure output file is not a directory, append .txt to the output filename if it has no file ending
if os.path.isdir(outputfilepath):
    outputfilepath = os.path.join(outputfilepath, "schedule_readable.txt")
else:
    fn, fe = os.path.splitext(outputfilepath)
    if not fe:
        outputfilepath = outputfilepath + ".txt"

with open(outputfilepath, "w") as outfile:
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
        if idx in blockDict:
            track_title = blockDict[idx]["title"]
            outfile.write(f"{days:<20}\t{timestr}\t{track_title}\n")
        else:
            outfile.write(timestr + "\n")
outfile.close()
print("Program Schedule points", len(schDict))
print("written programfile to", outputfilepath)
