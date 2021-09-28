# OSC-Router and Processor

The OSC-Router written in python serves as central interface for OSC-messages in a multiclient spatial rendering environment.
It automatically translates incoming OSC-messages to match the expected formats of the rendering-engines and distributes it to all connected clients including UI-Clients and Data-clients for automation data.

## Quick-Info

Port: 4455

There are 32 sources which can be set via the following messages:

### Messages with source-index in osc-address:
- Position
   * `/source/1/xyz fff` 
   * `/source/1/aed fff`
- Gain
    * `/source/1/ambi f`
    * `/source/1/wfs f` 
    * `/source/1/reverb f`

### Messages with source index as argument:
- Position
    * `/source/xyz ifff` 
    * `/source/aed ifff`
- Gain
    * `/source/ambi if` 
    * `/source/wfs if` 
    * `/source/reverb if`

### Possible coordinate prefixes:
- Polar (angles in degree -180:180)
aed, ae, ad, ed, azim, elev, dist
- Cartesian
xyz, xy, xz, yz, x, y, z


## OSC-Router config

The OSC-Router is started by executing the `MAIN_oscrouter.py`. Per default it loads the configurationfile `oscRouterConfig.txt` in the same folder. With the argument `--config` another file can be loaded.

The configfile consists of a number of blocks which are divided with `***`. For more information have a look at `configSample.txt`

It provides an additional debug option: using the option `--oscdebug` followed by a string with ip and port (e.g. `--oscdebug "192.168.3.2:55112"`) an additional OSC-listener can be defined, which receives a copy of every OSC-message sent out by the OSC-router.


## accepted OSC messages
port:4455

The Osc-Router accepts various message formats and take care of converting them to the right format. Every OSC-Message consists of a OSC-Address Prefix followed by a number of values. Here we only work with integer- (i) and float-values (f)

Source IDs begins with Index 1 and can go up to 32. The following examples demonstrate which OSC-Messages are accepted for position data. 

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

If confgured in the config file the gains can also be set with the name of the renderer:
* `/source/1/wfs f`
* `/source/1/ambi f`
* `/source/1/rev f`


### secondary Port
Port: 4007
The secondary port has basically the same function as the main port 4455 but messages coming in on the main port are causing messages on the secondary port to be ignored for 2sec (configurable in the config-file). This happens separately for each source.


## Subcription-Protocol
Subcription-Port: 4999
Source-Data-Port: 4455

The connection is initialised by a subscricption-request from the client which is followed by a regular ping-message from the OSC-router that must by answered by a pong-message in order to keep the subscription alive. Source-Position and gain messages should be sent to port 4455 and the subcription-messages to port 4999.


### Subscribe 
A client can subscribe to all position and gain messages e.g. a viewer-client during production process. Subcriptions and pong messages should be send to port 4999.
The connection is initialised via:
`/oscrouer/subscribe s i s (i i)` with s = uniqueClientName, i=listeningPort, s=coordinateFormat, i=sourceIndexInOsc(0/1), i=minUpdateIntervall
The last three arguments are optional and are set to '1 10' by default. 
e.g. `/oscrouter/subscribe maxViewer 55123 xyz 1 10`
will send source-position messages to the subscribing client as follows:
* For Position
    `/source/1/xyz fff` with a max. rate of 100Hz (every 10 ms).
* For gains e.g.
 `/source/1/ambi f`

The ip-Address of the client is retrieved automatically from the udp-packet by the OSC-Router.
 
 ### ping-pong

The osc-router send the message
`/oscrouter/ping 4999`
which should be answered (to port 4999) with
`/oscrouter/pong uniqueClientName`
The uniqueClientName has to be the same as in the subcription message. 
If the client does not answer to the ping message he will be erased after a certain time. 


## Debug functions
Port: 4999

A copy of all outgoing osc-messages from the osc-router can requested by sending:
`/oscrouter/debug/osccopy ipAddress:port` with ipAddress and listening port of the receiving machine e.g. `/oscrouter/debug/osccopy 192.168.3.2:55112`
The debug-osc messages contain the name of the target as well as ip-address and port.
To deactivate this send a message without target address: `/oscrouter/debug/osccopy`

With the message `/oscrouter/debug/verbose i` a verbosity level can be set which activates console printing of incoming and outcoming messages as well as further informations. 
Set verbosity to 0 when to stop console output which can significantly slow down the system. 



