import subprocess
import os
import shutil
from pathlib import Path

video_path = Path(__file__).parent / "videos"
tiff_path = Path(__file__).parent / "tiffs"
output_path = Path(__file__).parent / "output_videos"
filenames = {
    "info00" : "trailer",
    "info01" : "bds",
    "info02" : "sufi",
    "info03" : "daten",
    "info04" : "weep",
    "info05" : "oksus",
    "info06" : "liquid",
    "info07" : "passage",
    "info08" : "triple",
    "info09" : "transformation",

}
if __name__=="__main__":
    
    for video_file in video_path.iterdir():
        if video_file.name[:-4] not in filenames:
            print(f"weird file? {video_file}")
            continue
        new_name = filenames[video_file.name[:-4]]
        shutil.copy(video_file, output_path / f"info_{new_name}.mp4")


    for tiff_file in tiff_path.iterdir():
        if tiff_file.name[:-4].lower() not in filenames:
            print(f"weird tiff file? {tiff_file}")
            continue
        new_name = filenames[tiff_file.name[:-4].lower()]
        output_file = output_path / f"info_{new_name}.mp4"
        subprocess.Popen(f"ffmpeg -loop 1 -i {tiff_file} -c:v libx264 -t 15 -pix_fmt yuv420p {output_file}", shell=True).wait()


