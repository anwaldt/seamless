import numpy as np
import str_keys_conventions as skc
import conversionsTools as ct
from functools import partial
from time import time


class SoundObject(object):

    globalConfig: dict = {}
    # data_port_timeout = 0.5
    number_renderer = 1
    # maxGain = 2.
    send_change_only = False

    def readGlobalConfig(cls):
        pass


    def __init__(self, objectID=0):

        self.objectID = objectID

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
        self._changedaAttributes: set = set()

        self._torenderer_sends = [0.] * self.number_renderer
        self._changedSends: set = set()


        self._positionIsSet = {
            skc.polar: False,
            skc.cartesian: True,
            skc.normcartesian: True,
            skc.polar_rad: False
        }
        self._lastUpdateKey = ''


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
        sthChanged = False

        if not self._positionIsSet[coordinateType] and not skc.posformat[coordinate_key][2]:
            self.updateCoordinateFormat(coordinateType)
            sthChanged = True

        for kk in self._positionIsSet.keys():
            self._positionIsSet[kk] = False

        self._lastUpdateKey = coordinate_key

        #TODO:copy old position

        # here the Position is set
        for idx, key in enumerate(skc.posformat[coordinate_key][1]):
            newValue = ct.f32(values[idx])
            if self.globalConfig[skc.send_changes_only]:
                if not newValue == self._position[key]:
                    sthChanged = True
                    self._position[key] = newValue
            else:
                self._position[key] = newValue
                sthChanged = True


            # self._position[key] = ct.f32(values[idx])

        self._positionIsSet[coordinateType] = True

        #TODO: compare new Position with old position for return
        return sthChanged


    def setPositionFromAutomation(self, coordinate_key: str, values) -> bool:

        if self._contState == skc.sControl_state.automation_control:
            return self.setPosition(coordinate_key, values)

        elif self._contState == skc.sControl_state.auto_switch_control:
            if self._manuallySetPosition:
                if (time() - self._lastUpdateTime) < self.globalConfig[skc.data_port_timeout]:
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

    def getSingleValueUpdate(self, keys):
        if self._lastUpdateKey in keys:
            return (self._lastUpdateKey, self._position[self._lastUpdateKey])
        else:
            return False

    def getPosition(self, pos_key) -> [float]:
        coordinateType = skc.posformat[pos_key][0]

        if not self._positionIsSet[coordinateType]:
            self.updateCoordinateFormat(coordinateType)

        coords = [] # np.array([], dtype=np.float32)
        for key in skc.posformat[pos_key][1]:
            coords.append(float(self._position[key]))
        # float_coords = coords.
        return coords


    def setSourceAttribute(self, attribute, value) -> bool:
        if not self._sourceattributes[attribute] == value:
            self._sourceattributes[attribute] = value
            return True
        else:
            return False

    def getChangedAttributes(self, attribute, value):
        pass

    def getSourceAttribute(self, attribute: skc.SourceAttributes) -> any:
        return self._sourceattributes[attribute]


    def setRendererGain(self, rendIdx: int, gain: float, fromUi:bool=True) -> bool:

        _gain = np.clip(gain, a_min=0, a_max=self.globalConfig[skc.max_gain])
        # print('set gain', gain, 'for index', rendIdx, 'my id is', self.objectID)
        # print('sends', self._torenderer_sends)
        if self.globalConfig[skc.send_changes_only]:
            if self._torenderer_sends[rendIdx] == _gain:
                return False

        self._torenderer_sends[rendIdx] = _gain
        self._changedSends.add(rendIdx)
        return True


#TODO: what if audiorouter is no singleton?
    def getAllRendererGains(self) -> [float]:
        # print(self._torenderer_sends)
        return self._torenderer_sends

    def getChangedGains(self) -> [(int, float)]:
        msgs = []
        while self._changedSends:
            sendIdx = self._changedSends.pop()
            msgs.append((sendIdx, self._torenderer_sends[sendIdx]))
        return msgs

    def getRendererGain(self, idx:int) -> float:
        return self._torenderer_sends[idx]



class LinkedObject(object):
    def __init__(self, **kwargs):
        super(LinkedObject, self).__init__(**kwargs)
