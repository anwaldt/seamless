import yaml
import os

def main():
    output_file = "schedule.yml"
    track_files = ""
    block_files = ""
    track_padding_time = 20

    for file in os.listdir("tracks"):
        if file.endswith(".yml"):
            with open(os.path.join('tracks', file)) as f:
                track_files += f.read()
    tracks = yaml.load(track_files, Loader=yaml.FullLoader)

    print('Tracks:')
    for track, info in tracks.items():
        print(info['title'])
        info['duration']['min'] = info['duration']['min'] + 1
        info['duration']['sec'] = 0

    for file in os.listdir("blocks"):
        if file.endswith(".yml"):
            with open(os.path.join('blocks', file)) as f:
                block_files += f.read()
    blocks = yaml.load(block_files, Loader=yaml.FullLoader)

    print('Blocks:')
    block_template = []

    for value in blocks.values():
        N = len(value)
        for i in range(N):
            title_name = value[i+1]
            duration = tracks[title_name]['duration']

            block_template[i]['title']
            print(f"{i}: {title_name} ({duration})")




if __name__ == "__main__":
    main()
