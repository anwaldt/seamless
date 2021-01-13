# HuFo_System

## SuperCollider OSC Paths

### Sends

#### To Ambisonics + WFS

```/send/gain/individual i i f ```

- first argument = channel ID
- second argument = system ID
  - 0 = Ambisonics (inside SC)
  - 1 = WFS (external, WONDER)

#### To Subwoofer

```/send/gain/common i i f ```

- first argument = channel ID
- second argument = output ID
  - 0 = Subwoofer

### Ambisonics Spatial Control

```/source/azim i f```

- first argument = channel ID
- second argument = angle (rad)

```/source/elev i f```

- first argument = channel ID
- second argument = angle (rad)

```/source/dist i f```

- first argument = channel ID
- second argument = distance (meters)

```/source/aed i f f f```

- first argument  = channel ID
- second argument = azimuth (degree)
- third argument  = elevation (degree)
- fourth argument = distance (meters)
