# OSC Paths

In their current version, the plugins
use the following OSC paths for sending
and receiving messages.


## Spatial

All spatial control messages get two arguments:

- the ID of the source to control (starting at index 1)
- the position (cuurently ranging from -10 to 10 meters).

### X Position

```console
/source/pos/x i f
```

### Y Position

```console
/source/pos/y i f
```

### Z Position

```console
/source/pos/z i f
```

## Bus Send

OSC messages for the send gains of the channels
take three arguments:

- the ID of the source to control (starting at index 1)
- the index of the bus to send to (starting at 0 OR 1)
- the gain (ranging from 0 to 1)

```console
/send/gain i i f
```
