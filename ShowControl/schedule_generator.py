import yaml
import os

def main():
    output_file = "schedule.yml"

    for file in os.listdir("tracks"):
        if file.endswith(".yml"):
            with open(file) as f:
                track_files += f
    tracks = yaml.load(track_files, Loader=yaml.FullLoader)


if __name__ == "__main__":
    main()
