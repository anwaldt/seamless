## Install Decoders


Copy the directory ``decoders`` to the SC user 
extension directory. It can be obtained in SC:

```Platform.userExtensionDir```




## SuperCollider OSC Paths

### Sends

#### To Ambisonics + WFS

```/source/send/spatial i i f ```

- first argument = channel ID
- second argument = system ID
  - 0 = Ambisonics (inside SC)
  - 1 = WFS (external, WONDER)

#### To Subwoofer

```/source/send/direct i i f ```

- first argument = channel ID
- second argument = output ID
  - 0 = Subwoofer

### Ambisonics Spatial Control

```/source/pos/azim i f```

- first argument = channel ID
- second argument = angle (rad)

```/source/pos/elev i f```

- first argument = channel ID
- second argument = angle (rad)

```/source/pos/dist i f```

- first argument = channel ID
- second argument = distance (meters)

```/source/pos/aed i f f f```

- first argument  = channel ID
- second argument = azimuth (degree)
- third argument  = elevation (degree)
- fourth argument = distance (meters)
