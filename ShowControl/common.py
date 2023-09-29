from pathlib import Path
import yaml


def read_tracks(track_dir: (str | Path), identifier_is_name=True) -> dict:
    """Reads all yaml track files in the specified directory

    Args:
        track_dir (str | Path): Directory that contains the track yamls
        identifier_is_name (bool, optional): Specifies if the returned dict uses the names of the tracks as the outermost key. If set to False the audio_index is used instead. Defaults to True.

    Raises:
        Exception:

    Returns:
        dict: Contains all tracks
    """

    track_dir = Path(track_dir)
    tracks = {}
    for track_file in track_dir.glob("*.yml"):
        with open(track_file) as f:
            track = yaml.load(f, Loader=yaml.FullLoader)

            if identifier_is_name:
                identifier = track["name"]
            else:
                identifier = track["audio_index"]

            if identifier in tracks:
                raise Exception(f"track identifier {identifier} is not unique!")

            tracks[identifier] = track

    return tracks


def read_blocks(block_dir) -> dict:
    block_dir = Path(block_dir)

    blocks = {}
    for block_file in block_dir.glob("*.yml"):
        with open(block_file) as f:
            block = yaml.load(f, Loader=yaml.FullLoader)

            identifier = block["name"]
            if identifier in blocks:
                raise Exception(f"Block identifier {identifier} is not unique")

            blocks[identifier] = block
    return blocks
