"""
Reads the show control schedule.yml -file and the defined blocks/tracks
and creates a readable list with time and title.

"""

import yaml
import argparse
import glob
import os

parser = argparse.ArgumentParser("Convert yaml file to readable program file .txt")
parser.add_argument("-i", "--inputfile", default="schedule_new.yml", type=str, help="schedule yml file to convert")
parser.add_argument("-o", "--outputfile", default="schedule_readable.txt", type=str, help="output file path or folder path for txt")
parser.add_argument("-t", "--tracksfolder", type=str, default="../Configs/HUFO/tracks", help="folder of the defined tracks/blocks")
args = parser.parse_args()


blockDict = dict() # Audioindices to block
blockpath = args.tracksfolder
outputfilepath = args.outputfile
inputfilepath = args.inputfile

# inputfilepath = "/Users/psch/_GitHub/seamless/Configs/HUFO/schedule.yml"
# blockpath = '/Users/psch/_GitHub/seamless/Configs/HUFO/tracks'
# outputfilepath = "/Users/psch/_GitHub/seamless/hufoprogram.txt"

def twoNr(num) -> str:
    if(num) < 10:
        return "0{}".format(num)
    else:
        return "{}".format(num)

_tracklist = []
for ymlfile in glob.glob(os.path.join(blockpath, '*.yml')):
    with open(os.path.join(os.getcwd(), ymlfile), 'r') as ymlf:
        _block: dict = yaml.safe_load(ymlf)
        if type(_block) == dict:
            for _v in _block.values():
                if 'title' in _v.keys():
                    blockDict[_v['title']] = _v
                    _tracklist.append(_v['title'])
                if 'audio_index' in _v.keys():
                    # trackcounter = trackcounter + 1
                    blockDict[_v['audio_index']] = _v

print("found tacks:", len(_tracklist), _tracklist)
# yaml.load("/Users/psch/_GitHub/seamless/ShowControl/schedule_new.yml", Loader=)



with open(inputfilepath, "r") as stream:
    schDict = yaml.safe_load(stream)
stream.close()

if(os.path.isdir(outputfilepath)):
    outputfilepath = os.path.join(outputfilepath, "schedule_readable.txt")
else:
    _fn, _fe = os.path.splitext(outputfilepath)
    if not _fe:
        outputfilepath = outputfilepath + ".txt"

_schedCounter = 0
with open(outputfilepath, 'w') as outfile:
    for _b in schDict:
        _schedCounter = _schedCounter +1
        _timestr = twoNr(_b['hour'])+":"+twoNr(_b["minute"])+":"+twoNr(_b["second"])


        _idx = _b['audio_index']
        if _idx in blockDict:
            outfile.write("{}\t{}\n".format(_timestr, blockDict[_idx]['title']))
        else:
            outfile.write(_timestr+"\n")
outfile.close()
print("Program Schedule points", _schedCounter)
print("written programfile to", outputfilepath)
