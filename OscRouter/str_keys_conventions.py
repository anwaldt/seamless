
coord_format = 'coord_format'
cartesian = 'cartesian'
polar = 'polar'
normcartesian = 'normcartesian'

x = 'x'
y = 'y'
z = 'z'
azim = 'azim'
azimuth = 'azim'
elev = 'elev'
elevation = 'elev'
dist = 'dist'
distance = 'dist'
angle = 'angle'

az_rad = 'az_r'
el_rad = 'ev_r'
polar_rad = 'pol_rad'


a = 'a'
e = 'e'
d = 'd'

# normalised xyz on a sphere with r = 1
nx = 'nx'
nxd = 'nxd'
ny = 'ny'
nyd = 'nyd'
nz = 'nz'
nzd = 'nzd'
nd = 'dist' #distance

aed = 'aed'
ad = 'ad'
ae = 'ae'
ed = 'ed'
aedrad = 'aedrad'
# arad = 'arad'
# erad = 'erad'

xyz = 'xyz'
xy = 'xy'
xz = 'xz'
yz = 'yz'

nxyz = 'nxyz'
nxyzd = 'nxyzd'
nxy = 'nxy'
nxyd = 'nxyd'
nxz = 'nxz'
nxzd = 'nxzd'
nyz = 'nyz'
nyzd = 'nyzd'

source_attributes = 'sourceattributes'
doppler = 'doppler'
plane = 'planewave'
planewave = 'planewave'

source_index = 'source_index'


ip_address = 'ip-address'
port_address = 'port-address'
max_update_rate = 'max_update_rate'  #in milliseconds between updates
osc_patterns = 'osc_patterns'
sourcespecific_osc_addstr = 'sourcespecific_osc' #True if sourceindex is part of address string
append_to_position = 'append_to_position'
source_offset = 'sourfce_offset'
transform_for_position = 'transform_for_position'

continuously_update_intervall = 'cont_updt_interv'



posformat = {
# cartesian xyz
        x: (cartesian, (x,), False),
        y: (cartesian, (y,), False),
        z: (cartesian, (z,), False),
        xy: (cartesian, (x, y), False),
        xz: (cartesian, (x, z), False),
        yz: (cartesian, (y, z), False),
        xyz: (cartesian, (x, y, z), True),
# polar aed
        azim: (polar, (azim,), False),
        a: (polar, (azim,), False),
        elev: (polar, (elev,), False),
        e: (polar, (elev,), False),
        dist: (polar, (dist,), False),
        d: (polar, (dist,), False),
        ad: (polar, (azim, dist), False),
        ed: (polar, (elev, dist), False),
        ae: (polar, (azim, elev), False),
        aed: (polar, (azim, elev, dist), True),
#Polar in rad
        aedrad: (polar_rad, (az_rad,el_rad,dist), True),
# oscar specific "normcartesian
        nx: (normcartesian, (nx,), False),
        nxd: (normcartesian, (nx, nd), False),
        ny: (normcartesian, (ny,), False),
        nyd: (normcartesian, (ny, nd), False),
        nz: (normcartesian, (nz,), False),
        nzd: (normcartesian, (nzd,), False),
        nxy: (normcartesian, (nx, ny), False),
        nxyd: (normcartesian, (nx, ny, nd), False),
        nyz: (normcartesian, (ny, nz), False),
        nyzd: (normcartesian, (ny, nz, nd), False),
        nxyz: (normcartesian, (nx, ny, nz), False),
        nxyzd: (normcartesian, (nx, ny, nz, nd), True),
        nd: (normcartesian, (nd,), False)
}
fullformat = {
        xyz: (x, y, z),
        nxyzd: (nx, ny, nz, nd),
        aed: (azim, elev, dist),
        cartesian: (x, y, z),
        normcartesian: (nx, ny, nz, nd),
        polar: (azim, elev, dist)
}
fullnames = {
        azim: 'azimuth',
        elev: 'elevation',
        dist: 'distance'
}

from enum import Enum
import numpy as np

class sControl_state(Enum):
        automation_control = np.ubyte(1)
        manually_control = np.ubyte(2)
        auto_switch_control = np.ubyte(0)


class renderClass(Enum):
    Wonder = 'wonder'
    Panoramix = 'panoramix'
    IemMultiencoder = 'iemmultiencoder'
    ViewClient = 'viewclient'
    Oscar = 'oscar'
    Scengine = 'scengine'
    Audiorouter = 'audiorouter'
    SeamlessPlugin = "seamlessplugin"
    AudiorouterWFS =  'AudiorouterWFS'


# sourceAttributes: dict = {
#         planewave: planewave,
#         doppler: doppler
# }
knownAttributes = {planewave, doppler}

class SourceAttributes(Enum):
        planewave = planewave
        doppler = doppler


class CoordFormats(Enum):
        nx = 'nx'
        nxd = 'nxd'
        ny = 'ny'
        nyd = 'nyd'
        nz = 'nz'
        nzd = 'nzd'
        nd = 'dist'  # distance

        aed = 'aed'
        ad = 'ad'
        ae = 'ae'
        ed = 'ed'
        xyz = 'xyz'
        xy = 'xy'
        xz = 'xz'
        yz = 'yz'

        nxyz = 'nxyz'
        nxyzd = 'nxyzd'
        nxy = 'nxy'
        nxyd = 'nxyd'
        nxz = 'nxz'
        nxzd = 'nxzd'
        nyz = 'nyz'
        nyzd = 'nyzd'



#global config keywords
globalconfig = 'globalconfig'
inputport_data = 'inputport_data'
inputport_ui = 'inputport_ui'
inputport_settings = 'inputport_settings'
number_sources = 'number_sources'
max_gain = 'max_gain'
send_changes_only = 'send_changes_only'
data_port_timeout = 'data_port_timeout'

renderengine = 'renderengine'
