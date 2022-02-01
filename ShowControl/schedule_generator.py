import yaml
import os

def main():
    output_file = "schedule.yml"
    track_files = ""
    track_padding_time = 20

    for file in os.listdir("tracks"):
        if file.endswith(".yml"):
            with open(os.path.join('tracks', file)) as f:
                track_files += f.read()
    tracks = yaml.load(track_files, Loader=yaml.FullLoader)
    for track in tracks:
        print(track['title'])

    for file in os.listdir("blocks"):
        if file.endswith(".yml"):
            with open(os.path.join('blocks', file)) as f:
                block_files += f.read()
    blocks = yaml.load(block, Loader=yaml.FullLoader)
    for block in blocks:
        print(track['title'])

    N = len(blocks['tracks'])
    for i in range(N):
        blocks['tracks'][i+1]
        print(blocks['tracks'][i+1])



if __name__ == "__main__":
    main()
