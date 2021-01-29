# OscRouter and processor

This python scripts serves as central interface for OSC-messages in a multiclient spatial rendering environment. 
It automatically translates incoming OSC-messages to match the expected formats of the rendering-engines and distributes it to all connected clients including UI-Clients and Data-clients for automation data. (Here Ircams OSCAR).

## accepted OSC messages
Source IDs begins with Index 1 and can go up to the number of source configured in the config file.

Source ID can be in the OSC-Prefix
``` /source/1/aed f f f ``` 

Or part of the Message-Values
``` /source/xyz i f f f``` with i f f f = <SourceID> <x> <y> <z>

The last component of the OSC-Prefix defines the coordinate format. Besides full sets of coordinates single coordinate values can be send too
```/source/azim i f```
```/source/1/x f```

as well as pairs 
```/source/1/ad f f ```
```/source/xy i f f```

Polar and Cartesian formats will automatically converted according to the target renderer.
For OSCAR a special "normalised cartesian" format is used which consists of a triplet of xyz-coordinats on a sphere with radius=1 and a distance factor. Those coordinates are sent separately to OSCAR for writing automation data in DAWs.


### TO-DO:
- Conversion of 3D-Coordinates to 2D-Coordinates, respecting the distance of the source
- Implementation of setting-commands and UI-specific functions
- Testing of all functions and stress-testing
