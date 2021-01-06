import numpy as np
import str_keys_conventions as skc
import conversionsTools as ct
from functools import partial
from time import time


class SoundObject(object):

    higher_priority_pos_timeout = 0.5
    number_renderer = 1


    def __init__(self):

        self._position: [str, np.float32] = {
            skc.x: ct.f32(0.),
            skc.y: ct.f32(1.),
            skc.z: ct.f32(0.),
            skc.azim: ct.f32(0.),
            skc.elev: ct.f32(0.),
            skc.dist: ct.f32(1.),
            skc.angle: ct.f32(0.),
            skc.nx: ct.f32(0.),
            skc.ny: ct.f32(1.),
            skc.nz: ct.f32(0.),
            skc.az_rad: ct.f32(0.),
            skc.el_rad: ct.f32(0.)
        }

        self._sourceattributes = {
            skc.SourceAttributes.planewave: 0,
            skc.SourceAttributes.doppler: 0
        }

        self._torenderer_send = [ct.f32(0.)] * self.number_renderer

        self._positionIsSet = {
            skc.polar: False,
            skc.cartesian: True,
            skc.normcartesian: True,
            skc.polar_rad: False
        }

        self._contState = skc.sControl_state.auto_switch_control

        self._lastUpdateTime = time()
        self._manuallySetPosition = False


    def getPositionValuesForKey(self, key: skc.CoordFormats) -> []:
        vals = []
        for kk in skc.posformat[key.value][1]:
            vals.append(self._position[kk])

        return vals

    def updateCoordinateFormat(self, updateFormat):

        statusTupel = (self._positionIsSet[skc.polar], self._positionIsSet[skc.cartesian], self._positionIsSet[skc.normcartesian])

        conversionMap = {
            skc.polar: {
                (False, True, True): (ct.conv_ncart2pol, skc.CoordFormats.nxyzd),
                (False, True, False): (ct.conv_cart2pol, skc.CoordFormats.xyz),
                (False, False, True): (ct.conv_ncart2pol, skc.CoordFormats.nxyzd)
            },
            skc.cartesian: {
                (True, False, True): (ct.conv_ncart2cart, skc.CoordFormats.nxyzd),
                (True, False, False): (ct.conv_pol2cart, skc.CoordFormats.aed),
                (False, False, True): (ct.conv_ncart2cart, skc.CoordFormats.nxyzd)
            },
            skc.normcartesian: {
                (True, True, False): (ct.conv_cart2ncart, skc.CoordFormats.xyz),
                (True, False, False): (ct.conv_pol2ncart, skc.CoordFormats.aed),
                (False, True, False): (ct.conv_cart2ncart, skc.CoordFormats.xyz)
            }
        }
        convert_metadata = conversionMap[updateFormat][statusTupel]
        conversion = partial(convert_metadata[0])#, skc.posformat[convert_metadata[1]])

        updatedCoo = conversion(*self.getPositionValuesForKey(convert_metadata[1]))
        for idx, coo in enumerate(skc.fullformat[updateFormat]):
            self._position[coo] = updatedCoo[idx]

        self._positionIsSet[updateFormat] = True


    def setPosition(self, coordinate_key: str, values) -> bool:

        coordinateType = skc.posformat[coordinate_key][0]

        if not self._positionIsSet[coordinateType] and not skc.posformat[coordinate_key][2]:
            self.updateCoordinateFormat(coordinateType)

        for kk in self._positionIsSet.keys():
            self._positionIsSet[kk] = False

        #TODO:copy old position

        # here the Position is set
        for idx, key in enumerate(skc.posformat[coordinate_key][1]):
            self._position[key] = ct.f32(values[idx])

        self._positionIsSet[coordinateType] = True

        #TODO: compare new Position with old position for return
        return True


    def setPositionFromAutomation(self, coordinate_key: str, values) -> bool:

        if self._contState == skc.sControl_state.automation_control:
            return self.setPosition(coordinate_key, values)

        elif self._contState == skc.sControl_state.auto_switch_control:
            if self._manuallySetPosition:
                if (time() - self._lastUpdateTime) < self.higher_priority_pos_timeout:
                    self._manuallySetPosition = False
                else:
                    return False

            return self.setPosition(coordinate_key, values)
        else:
            return False


    def setPositionFromUserInterface(self, coordinate_key: str, values) -> bool:
        if self._contState == skc.sControl_state.auto_switch_control or self._contState == skc.sControl_state.manually_control:
            self._manuallySetPosition = True
            self._lastUpdateTime = time()
            self.setPosition(coordinate_key, values)
            return True
        else:
            return False


    def setControlState(self, state: skc.sControl_state):
        self._contState = state


    def getPosition(self, pos_key) -> [float]:
        coordinateType = skc.posformat[pos_key][0]

        if not self._positionIsSet[coordinateType]:
            self.updateCoordinateFormat(coordinateType)

        coords = [] # np.array([], dtype=np.float32)
        for key in skc.posformat[pos_key][1]:
            coords.append(float(self._position[key]))
        # float_coords = coords.
        return coords


    def setSourceAttribute(self, attribute, *args):
        pass

    def getSourceAttribute(self, attribute: skc.SourceAttributes) -> any:
        return self._sourceattributes[attribute]


class LinkedObject(object):
    def __init__(self, **kwargs):
        super(LinkedObject, self).__init__(**kwargs)
