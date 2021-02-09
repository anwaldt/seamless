# OSC-Router and Processor

The OSC-Router written in python serves as central interface for OSC-messages in a multiclient spatial rendering environment.
It automatically translates incoming OSC-messages to match the expected formats of the rendering-engines and distributes it to all connected clients including UI-Clients and Data-clients for automation data. (Here Ircams OSCar).

## OSC-Router config

The OSC-Router is started by executing the `MAIN_oscrouter.py`. Per default it loads the configurationfile `oscRouterConfig.txt` in the same folder. With the argument `--config` another file can be loaded.

The configfile consists of a number of blocks which are divided with `***`. For more information have a look at `configSampe.txt`

It provides an additional debug option: using the option `--oscdebug` followed by a string with ip and port (e.g. `--oscdebug "192.168.3.2 55112"`) an additional OSC-listener can be defined, which receives a copy of every OSC-message sent out by the OSC-router.


## accepted OSC messages
The Osc-Router accepts various message formats and take care of converting them to the right format. Every OSC-Message consists of a OSC-Address Prefix followed by a number of values. Here we only work with integer- (i) and float-values (f)

Source IDs begins with Index 1 and can go up to 64. The following examples demonstrate which OSC-Messages are accepted for position data. 

* Source ID can be in the OSC-Prefix
` /source/1/aed f f f `  with f f f = _azimuth elevation distance_

* Or part of the Message-Values
` /source/xyz i f f f` with i f f f = _sID x y z_

* The last component of the OSC-Prefix defines the coordinate format. Besides full sets of coordinates single coordinate values can be send too
`/source/azim i f` ,
`/source/1/x f`

* as well as pairs 
`/source/1/ad f f ` , 
`/source/xy i f f `

Polar and Cartesian formats will automatically converted according to the target renderer.

A **gain-send** value has to be given which is the amount of audio sent to a specific rendering module (e.g. Ambisonics, WFS).

`/source/send/spatial i i f` with i i f = _sourceID renderingID gain(linear)_

A **direct-send** to a speaker can be given:

'/source/send/direct i i f' with i i f = _sourceID outputID gain(linear)_ (0 = Subwoofer)

Settubg render-specific attributes:

* `/source/doppler i i` with i i = _sourceID 0/1_
* `/source/planewvae i i` with i i = _sourceID 0/1_
