import yaml
import os

def main():
    output_file = "schedule.yml"
    track_files = ""
    for file in os.listdir("tracks"):
        if file.endswith(".yml"):
            with open(os.path.join('tracks', file)) as f:
                track_files += f.read()
    tracks = yaml.load(track_files, Loader=yaml.FullLoader)
    for track in tracks:
        print(track['title'])

if __name__ == "__main__":
    main()
