import os
import time, datetime

filename = "schedule_new.yml"

outfile = open(filename, "w")

#outfile.write("test")



audioIndcs = [1,2,3, 1, 4,5]
tracklength = [180, 974, 1145, 1049, 1200]

startPer80min = [0, 200, 1180, 2345, 2540, 3595]

deltaPieces = []
for dd in startPer80min:
    deltaPieces.append(datetime.timedelta(seconds=dd))

startzeit = datetime.datetime(2022, 2, 1, 9,0 ,0)


def days_hours_minutes(td):
    _h = td.seconds//3600
    _hmin = _h * 60
    _m = (td.seconds//60)%60
    _s = int((_hmin + _m)%60)
    return _h, _m, _s#td.seconds//3600, (td.seconds//60)%60

lengthsec = 4800
blockTDelta = datetime.timedelta(minutes=80)

lines = ["- audio_index: {}\n",
         "  command: play\n",
         "  day_of_week: 0,1,2,3,4,5,6\n",
         "  hour: {}\n",
         "  minute: {}\n",
         "  second: {}\n",
         "  video_index: {}\n"
]

def hours(secs):
    return int((secs/60)/60)

def mins(secs):
    return int(secs%60)

def secs(secs):
    return (secs/60)%60


def writeBlock(file, _hour, _minute,  _secs,audIdx, vidx):
    # _hour = hours(seconds)
    # _minute = mins(seconds)
    # _secs = secs(seconds)

    file.write(lines[0].format(audIdx))
    file.write(lines[1])
    file.write(lines[2])
    file.write(lines[3].format(_hour))
    file.write(lines[4].format(_minute))
    file.write(lines[5].format(_secs))
    file.write(lines[6].format(vidx))

itera = 0

_blockStart = startzeit
for i in range(12):

    # offset = lengthsec + itera

    for j in range(6):
        piecStar = _blockStart + deltaPieces[j]
        writeBlock(outfile, piecStar.hour, piecStar.minute, piecStar.second, audioIndcs[j], itera)
        itera = itera + 1

    _blockStart = _blockStart + blockTDelta



outfile.close()