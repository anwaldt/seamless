import yaml
import os
from datetime import datetime, timedelta
from pathlib import Path


def writeEntry(file, _hour, _minute, _secs, _audio_idx, _video_idx):
    file.write(
        f"- audio_index: {_audio_idx}\n"
        f"  command: play\n"
        f"  day_of_week: 0,1,2,3,4,5,6\n"
        f"  hour: {_hour}\n"
        f"  minute: {_minute}\n"
        f"  second: {_secs}\n"
        f"  video_index: {_video_idx}\n"
    )


def main():
    path_config = Path(__file__).parent.parent / "Configs/HUFO"
    startzeit = datetime(2022, 2, 1, 10, 40, 0)
    output_file = path_config / "schedule.yml"
    track_files = ""
    block_files = ""
    video_continuous_index = False
    _video_idx = -1

    # load tracks
    for file in os.listdir(path_config / "tracks"):
        if file.endswith(".yml"):
            with open(path_config / "tracks" / file) as f:
                track_files += f.read()
    tracks = yaml.load(track_files, Loader=yaml.FullLoader)

    # load blocks
    for file in os.listdir(path_config / "blocks"):
        if file.endswith(".yml"):
            with open(path_config / "blocks" / file) as f:
                block_files += f.read()
    blocks = yaml.load(block_files, Loader=yaml.FullLoader)

    # load block plan
    with open(path_config / "blockplan.yml") as f:
        blockplan = yaml.load(f.read(), Loader=yaml.FullLoader)

    N_bp = len(blockplan["default"]["blocks"])
    blockstart = startzeit

    with open(output_file, "w") as out_file:
        for i in range(N_bp):
            blockname = blockplan["default"]["blocks"][i + 1]
            # print(f"{i+1}. blockname: {blockname}")
            block = blocks[blockname]
            # print(
            # f"Block Length: {block['length']} minutes\n"
            # f"Track Padding: {block['track_padding']} seconds"
            # )

            N = len(block["tracks"])

            trackstart = blockstart
            for i in range(N):
                title_name = block["tracks"][i + 1]
                _audio_idx = tracks[title_name]["audio_index"]
                if video_continuous_index:
                    _video_idx += 1
                else:
                    _video_idx = tracks[title_name]["video_index"]
                _minutes = tracks[title_name]["duration"]["minutes"]
                _seconds = tracks[title_name]["duration"]["seconds"]

                print(
                    f"- audio_index: {_audio_idx}\n"
                    f"  command: play\n"
                    f"  day_of_week: 0,1,2,3,4,5,6\n"
                    f"  hour: {trackstart.hour}\n"
                    f"  minute: {trackstart.minute}\n"
                    f"  second: {trackstart.second}\n"
                    f"  video_index: {_video_idx}"
                )

                writeEntry(
                    out_file,
                    trackstart.hour,
                    trackstart.minute,
                    trackstart.second,
                    _audio_idx,
                    _video_idx,
                )

                trackstart = (
                    trackstart
                    + timedelta(minutes=_minutes, seconds=_seconds)
                    + timedelta(seconds=block["track_padding"])
                )
            blockstart = blockstart + timedelta(minutes=block["length"])


if __name__ == "__main__":
    main()
