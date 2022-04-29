# import renderer_config as reconf
from soundobjectclass import SoundObject
import str_keys_conventions as skc
from str_keys_conventions import renderClass as renderclasstype
import conversionsTools as ct
from oscpy.client import OSCClient
# import oscpy.client as oscsock
import time
from threading import Timer
from functools import partial
from sched import scheduler
# from enum import Enum
from collections.abc import Iterable

verbosity = 0

class Renderer(object):

    numberOfSources = 64
    sources: [SoundObject] = []
    globalConfig = {}
    debugCopy: bool = False
    oscDebugClient: OSCClient

    printOutput = verbosity >= 1

    @classmethod
    def createDebugClient(cls, ip, port):
        cls.oscDebugClient = OSCClient(ip, port)
        # print(ip, port, cls.oscDebugClient)

    @classmethod
    def setVerbosity(cls, v: int):
        global verbosity
        verbosity = v
        cls.printOutput = verbosity >= 1

    def __init__(self, dataformat=skc.xyz,
                 updateintervall=10,
                 ipaddress='127.0.0.1',
                 listenport=4002,
                 continuously_update_intervall=-1,
                 renderid=-1,
                 sendport=0,
                 sourceattributes=(),
                 indexAsValue=0):

        self.setVerbosity(verbosity)

        self.renderid = int(renderid)
        self.posFormat = dataformat
        self.validSinglePosKeys = {}
        self.sourceAttributes = sourceattributes
        self.ipaddress = [ipaddress]
        self.listenport = [int(listenport)]
        self.updateIntervall = int(updateintervall) / 1000
        self.continuously_update_intervall = int(continuously_update_intervall)

        self.source_needs_update = [False] * self.numberOfSources
        self.source_getting_update = [False] * self.numberOfSources
        self.updateStack: [set] = [set()] #Tupel (<getValueFromSource function> </osctring>)
        for s in range(1, self.numberOfSources):
            self.updateStack.append(set())

        self.debugPrefix = "/genericRenderer"
        self.oscPre = ('/source/'+self.posFormat).encode()

        self.sendOsc = True

        self.multipleDestinations = False

        self.continous_update = self.continuously_update_intervall > 0

        self.toRender: [OSCClient] = []
        for idx, ip in enumerate(self.ipaddress):
            self.toRender.append(OSCClient(ip, self.listenport[0], encoding='utf8'))

        self.isDataClient = False

        self.printRenderInformation()

        # self.sources_updatecounter = 0

    def stopOscSend(self, pauseDuration=20):
        self.sendOsc = False
        if pauseDuration>0:
            Timer(pauseDuration, self.startOscSend)

    def startOscSend(self):
        self.sendOsc = True


    def printRenderInformation(self):
        info = [self.myType(), '\n',
              'address:', self.ipaddress, 'listenport:', self.listenport, '\n',
              'listening to format', self.posFormat, '\n']
        if self.renderid >= 0:
            info.insert(1, 'renderID:')
            info.insert(2, self.renderid)
        print(*info)

    def myType(self) -> str:
        return 'basic Rendererclass: abstract class, doesnt listen'

    def addDestination(self, ip: str, port: int):
        self.toRender.append(OSCClient(ip, port, encoding='utf8'))

        print(self.myType(), 'added destination', ip, str(port))

    def setContinousUpdateIntervall(self, update):
        self.continuously_update_intervall = update
        self.continous_update = update > 0

    def composeSourceUpdateMessage(self, values, sIdx: int=0, *args) -> [(bytes, [])]:
        return [(args[0], values)]

    def sourceChanged(self, source_idx):
        if not self.source_getting_update[source_idx]:
            self.updateSource(source_idx)
        else:
            self.source_needs_update[source_idx] = True

    def updateSource(self, source_idx):

        while self.updateStack[source_idx]:
            getValueFunc, oscPre = self.updateStack[source_idx].pop()
            values = getValueFunc()

            # print("wonder update Source:",oscPre)
            msgs = self.composeSourceUpdateMessage(values, source_idx, *oscPre)
            self.sendUpdates(msgs)

        self.scheduleSourceUpdateCheck(source_idx)

    def sendUpdates(self, msgs):
        for msg in msgs:
            for toRenderClient in self.toRender:
                try:
                    oscArgs = msg[1]
                    toRenderClient.send_message(msg[0], oscArgs)
                    # if isinstance(oscArgs, Iterable):
                    #     toRenderClient.send_message(msg[0], oscArgs)
                    # else:
                    #     toRenderClient.send_message(msg[0], [oscArgs])
                except:
                    pass#print('sendfail')

                if self.debugCopy:
                    debugOsc = (self.debugPrefix + '/' + toRenderClient.address + ':' + str(toRenderClient.port)  + msg[0].decode()).encode()
                    try:
                        self.oscDebugClient.send_message(debugOsc, msg[1])
                    except:
                        pass



            if self.printOutput:
                self.printOscOutput(msg[0], msg[1])


    def sendToDebugClient(self):
        pass


    def scheduleSourceUpdateCheck(self, source_idx):
        self.source_needs_update[source_idx] = False
        self.source_getting_update[source_idx] = True
        Timer(self.updateIntervall, partial(self.check_sourceNeedsUpdate, source_idx)).start()

    def check_sourceNeedsUpdate(self, source_idx):
        self.source_getting_update[source_idx] = False
        if self.source_needs_update[source_idx]:
            self.updateSource(source_idx)

# implement this functions in subclasses for registering for specific updates
    def sourceAttributeChanged(self, source_idx, attribute):
        pass

    def sourceRenderGainChanged(self, source_idx, render_idx):
        pass

    def sourceDirectSendChanged(self, source_idx, send_idx):
        pass

    def sourcePositionChanged(self, source_idx):
        pass

        # print('blabla')

# the following were not needed anymore
    def sendSourcePosition(self, source_idx):
        pass

    def sourceNeedGainUpdate(self, source_idx):
        pass

    def sendSourceAttributeMessage(self, sidx, attribute):
        pass


# future functions. Mainly intended for UIs so maybe move in that subclass
    def getSceneData(self):
        for idx in range(len(self.sources)):
            self.sendSourcePosition(idx)


    def oscDebugSend(self, oscStr, data: []):
        decStr = oscStr.decode()
        newOscAddr = self.debugPrefix + decStr
        self.oscDebugClient.send_message(newOscAddr.encode(), data)

    def printOscOutput(self, oscStr, data: []):
        decStr = oscStr.decode()
        # newOscAddr = self.debugPrefix + decStr
        print('OSC out', self.debugPrefix, decStr, data)
        # self.oscDebugClient.send_message(newOscAddr.encode(), data)

class SpatialRenderer(Renderer):

    def myType(self) -> str:
        return 'Generic Spatial Renderer'

    def sourcePositionChanged(self, source_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getPosition, self.posFormat),
                                          (self.oscPre,)))
        self.sourceChanged(source_idx)

    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        return [(args[0], *values)]



import math as ma
from shapely.geometry import Point, Polygon
class Wonder(SpatialRenderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.xy
        if not 'sourceattributes' in kwargs.keys():
            kwargs['sourceattributes'] = (skc.SourceAttributes.doppler, skc.SourceAttributes.planewave)
        super(Wonder, self).__init__(**kwargs)

        self.attributeOsc = {
            skc.SourceAttributes.doppler: b'/WONDER/source/dopplerEffect',
            skc.SourceAttributes.planewave: b'/WONDER/source/type'
        }
        self.oscPre = b'/WONDER/source/position'
        self.oscAnglePref = b'/WONDER/source/angle'

        self.interpolTime = self.updateIntervall
        self.linkPositionAndAngle = True

        self.wonderOscMap = {
            b'/WONDER/source/position': self.wonderPositionValues,
            b'/WONDER/source/angle': self.wonderAngleValues,
            b'/WONDER/source/dopplerEffect': self.wonderDopplerValues,
            b'/WONDER/source/type': self.wonderPlanewave
        }

        self.polygonInnerShift = 0.2
        self.deadStripeWidth = 1
        self.renderPolygon = self.createPolygonObject()

        self.debugPrefix = "/dWonder"

    def myType(self) -> str:
        return 'Wonder'

    def sourceAttributeChanged(self, source_idx, attribute):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getAttribute, attribute),
                                          (self.attributeOsc[attribute],)))
        self.sourceChanged(source_idx)


    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        osc_pre = args[0]

        send_values = self.wonderOscMap[osc_pre](sIdx, values)

        return [(osc_pre, send_values)]

    def wonderPositionValues(self, sIdx:int, values) -> []:
        if self.linkPositionAndAngle and self.sources[sIdx].getAttribute(skc.SourceAttributes.planewave):
            self.addUpdateAngleToStack(sIdx)

        values = self.validatePosition(values)

        return [sIdx, *values, self.interpolTime]

    def wonderAngleValues(self, sIdx, values) -> []:
        #TODO: Umrechnen
        return [sIdx, values, self.interpolTime]

    def wonderDopplerValues(self, sIdx, value) -> []:
        return [sIdx, value]

    def wonderPlanewave(self, sIdx, value) -> []:
        if value:
            self.addUpdateAngleToStack(sIdx)
        return [sIdx, int(not value)]

    def addUpdateAngleToStack(self, sIdx:int):
        self.updateStack[sIdx].add((partial(self.sources[sIdx].getPosition, skc.azim), (self.oscAnglePref,)))


    # hack functions
    def validatePosition(self, values) -> (float, float):
        p = Point(*values)
        dis = p.distance(self.renderPolygon)
        if dis == 0.0 or dis > self.deadStripeWidth:
            return values
        else:
            _abs = p.distance(Point(0, 0))
            _mvDist = self.deadStripeWidth - dis
            _mvX = p.x + ((p.x / _abs) * _mvDist)
            _mvY = p.y + ((p.y / _abs) * _mvDist)
            return _mvX, _mvY

    def createPolygonObject(self) -> Polygon:
        pointStrs = '-1.62,3.023\n1.62,3.023\n2.43,1.62\n2.43,-1.62\n1.62,-3.023\n-1.62,-3.023\n-2.43,-1.62\n-2.43,1.62'.split()
        pointList = []
        shift = self.polygonInnerShift
        for pStr in pointStrs:
            _x = float(pStr.split(',')[0])
            _y = float(pStr.split(',')[1])
            # shift polygon it slightly inside
            absXy = ma.sqrt(_x ** 2 + _y ** 2)
            _x = _x - ((_x/absXy) * shift)
            _y = _y - ((_y / absXy) * shift)
            pointList.append((_x, _y))

        return Polygon(pointList)





class Audiorouter(Renderer):
    #
    def __init__(self, **kwargs):
        super(Audiorouter, self).__init__(**kwargs)

        self.debugPrefix = "/dAudiorouter"
        self.oscpre_renderGain = b'/source/send/spatial'
        self.oscpre_reverbGain = b'/source/reverb/gain'
        self.oscpre_directSend = b'/source/send/direct'


    def printRenderInformation(self):
        info = [self.myType(), '\n',
              'address:', self.ipaddress, 'listenport:', self.listenport, '\n',
              'listening to format', 'send to render gains', '\n']
        if self.renderid >= 0:
            info.insert(1, 'renderID:')
            info.insert(2, self.renderid)
        print(*info)


    def myType(self) -> str:
        return 'Audiorouter'

    # def updateSource(self, source_idx):
    #
    #     while self.updateStack[source_idx]:
    #         getValueFunc, oscPre, secondIndex = self.updateStack[source_idx].pop()
    #         value = getValueFunc()
    #         msgs = self.composeSourceUpdateMessage(value, source_idx, secondIndex, *oscPre)
    #         self.sendUpdates(msgs)
    #
    #     self.scheduleSourceUpdateCheck(source_idx)

    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:

        osc_pre = args[0]

        if osc_pre == self.oscpre_reverbGain:
            return [(osc_pre, [sIdx, values])]
        else:
            cIdx = args[1]
            return [(osc_pre, [sIdx, cIdx, values])]

#TODO: better solution putting a tuple of three values in there?
    def sourceDirectSendChanged(self, source_idx, send_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getDirectSend, send_idx), (self.oscpre_directSend, send_idx)))
        self.sourceChanged(source_idx)

    def sourceRenderGainChanged(self, source_idx, render_idx):
        if not render_idx == 1:
            if render_idx == 2:
                self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.oscpre_reverbGain, render_idx)))
            else:
                self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.oscpre_renderGain, render_idx)))
            self.sourceChanged(source_idx)

class AudiorouterWFS(Audiorouter):

    def __init__(self, **kwargs):
        super(AudiorouterWFS, self).__init__(**kwargs)
        self.debugPrefix = '/dAudiorouterWFS'

    def sourceRenderGainChanged(self, source_idx, render_idx):
        if render_idx == 1:
            self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.oscpre_renderGain, render_idx)))
            self.sourceChanged(source_idx)

    def myType(self) -> str:
        return 'Audiorouter-WFS'


class Panoramix(SpatialRenderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.xyz
        super(Panoramix, self).__init__(**kwargs)

        self.posAddrs = []
        for i in range(self.numberOfSources):
            self.posAddrs.append(('/track/' + str(i+1) + '/xyz').encode())

        self.debugPrefix = "/dPanoramix"

    def myType(self) -> str:
        return 'Panoramix CAREFUL NOT REALLY IMPLEMENTED'

    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        # msgs = []
        sobject = self.sources[sIdx]
        position = sobject.getPosition(self.posFormat)
        # sourceID = source_idx + 1
        addr = self.posAddrs[sIdx]

        return [(addr, position)]


class IemMultiencoder(SpatialRenderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.ae
        # kwargs[skc.posformat] = skc.aed
        super(IemMultiencoder, self).__init__(**kwargs)

        self.posAddrs = [{}] * self.numberOfSources
        for i in range(self.numberOfSources):

            for kk in skc.posformat[self.posFormat][1]:
#TODO: Check if the right strings
                addrstr = '/MultiEncoder/' + str(i) + skc.fullnames[kk]
                self.posAddrs.append(addrstr)

        self.debugPrefix = "/dIEM"


    def myType(self) -> str:
        return 'IEM Multiencoder, NOT IMPLEMENTED'


    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        pass


class SuperColliderEngine(SpatialRenderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.aed
        super(SuperColliderEngine, self).__init__(**kwargs)

        self.oscPre = b'/source/pos/aed'
        self.singleValKeys = {
            skc.azim: b'/source/pos/azim',
            skc.dist: b'/source/pos/dist',
            skc.elev: b'/source/pos/elev'
        }
        self.validPosKeys = {skc.azim, skc.dist, skc.elev}

        self.debugPrefix = "/dSuperCollider"

    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        osc_pre = args[0]
        return [(osc_pre, [sIdx, *values])]
        # sobject = self.sources[source_idx]
        # singleUpdate = sobject.getSingleValueUpdate(self.validPosKeys)
        # if singleUpdate:
        #     return [(self.singleValKeys[singleUpdate[0]]), [singleUpdate[1]]]
        #
        # else:
        #     position = sobject.getPosition(self.posFormat)
        #     return [(self.addrstr, [source_idx + 1, *position])]


    def myType(self) -> str:
        return 'Supercolliderengine'


class ViewClient(SpatialRenderer):

    def myType(self) -> str:
        return 'viewClient: {}'.format(self.alias)

    def __init__(self, aliasname, **kwargs):
        self.alias = aliasname

        super(ViewClient, self).__init__(**kwargs)

        self.pingCounter = 0

        self.debugPrefix = "/d{}".format(aliasname.decode())
        # self.biAlias = b''
        # self.setAlias(aliasname)

        self.indexAsValue = False
        if 'indexAsValue' in kwargs.keys():
            self.indexAsValue = kwargs['indexAsValue']

        self.idxSourceOscPrePos = [b''] * self.numberOfSources
        self.idxSourceOscPreAttri = [{}] * self.numberOfSources
        self.idxSourceOscPreRender = [[]] * self.numberOfSources

        self.createOscPrefixes()

                # self.idxSourceOscPreAttri

        self.pingTimer: Timer = None


    def createOscPrefixes(self):
        for i in range(self.numberOfSources):
            self.idxSourceOscPrePos[i] = '/source/{}/{}'.format(i+1, self.posFormat).encode()
            _aDic = {}
            for attr in skc.knownAttributes:
                _aDic[attr] = '/source/{}/{}'.format(i+1, attr).encode()

            self.idxSourceOscPreAttri[i] = _aDic
            renderList = [b''] * self.globalConfig['number_renderunits']
            if 'index_ambi' in self.globalConfig.keys() and 'index_wfs' in self.globalConfig.keys() and 'index_reverb' in self.globalConfig.keys():
                renderList[self.globalConfig['index_ambi']] = '/source/{}/ambi'.format(i+1).encode()
                renderList[self.globalConfig['index_wfs']] = '/source/{}/wfs'.format(i+1).encode()
                renderList[self.globalConfig['index_reverb']] = '/source/{}/reverb'.format(i+1).encode()
            else:
                for j in range(self.globalConfig['number_renderunits']):
                    self.idxSourceOscPreRender[i][j] = '/source/{}/send/{}'.format(i+1, j).encode()
            self.idxSourceOscPreRender[i] = renderList


    def checkAlive(self, deleteClient):

        self.pingTimer = Timer(2., partial(self.checkAlive, deleteClient))

        if self.pingCounter < 6:
            # self.toRender[0].send_message(b'/oscrouter/ping', [self.globalConfig['inputport_settings']])
            try:
                self.toRender[0].send_message(b'/oscrouter/ping', [self.globalConfig['inputport_settings']]) #, self.alias
            except:
                print('ERROR while pinging client', self.alias)
                self.pingTimer.cancel()
                deleteClient(self, self.alias)

            self.pingCounter += 1
            self.pingTimer.start()
        else:
            deleteClient(self, self.alias)

    def receivedIsAlive(self):
        # print('received is alive')
        self.pingCounter = 0

    def sourcePositionChanged(self, source_idx):
        if self.indexAsValue:
            self.updateStack[source_idx].add((partial(self.sources[source_idx].getPosition, self.posFormat),
                                              (self.idxSourceOscPrePos[source_idx],)))
        else:
            self.updateStack[source_idx].add((partial(self.sources[source_idx].getPosition, self.posFormat),
                                          (self.oscPre,)))
        self.sourceChanged(source_idx)

    def sourceRenderGainChanged(self, source_idx, render_idx):
        # print('view client notified for renderchange', source_idx, render_idx)
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.idxSourceOscPreRender[source_idx][render_idx],)))
        # print(self.updateStack)
        #
        # if render_idx == 2:
        #     self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.oscpre_reverbGain, render_idx)))
        # else:
        #     self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.oscpre_renderGain, render_idx)))
        self.sourceChanged(source_idx)



    def composeSourceUpdateMessage(self, values, sIdx: int=0, *args) -> [(bytes, [])]:
        if isinstance(values, Iterable):
            return [(args[0], values)]
        else:
            return [(args[0], [values])]


    #TODO: send complete Scene data


class Oscar(SpatialRenderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.aed
        super(Oscar, self).__init__(**kwargs)

        self.sourceAttributes = (skc.SourceAttributes.doppler, skc.SourceAttributes.planewave)

        # self.posAddrs = []

        self.oscPosPre =[]
        self.oscAttrPre = []
        self.oscRenderPre = []
        self.oscDirectPre = []

        # self.oscAttributeOscPre = {
        #     skc.SourceAttributes.doppler: [],
        #     skc.SourceAttributes.planewave: []
        # }

        for i in range(self.numberOfSources):
            sourceAddrs = {}
            for kk in skc.fullformat[self.posFormat]:
                addrStr = '/source/' + str(i+1) + '/' + kk
                sourceAddrs[kk] = addrStr.encode()
            self.oscPosPre.append(sourceAddrs)

            attrDic = {}
            for key in self.sourceAttributes:
                oscStr = '/source' + str(i+1) + '/' + key.value
                attrDic[key] = oscStr.encode()
            self.oscAttrPre.append(attrDic)

            renderGainOscs = []
            for rId in range(self.globalConfig['numberofrenderengines']):
                riOsc = '/source/' +str(i+1) + '/render/' + str(rId)
                renderGainOscs.append(riOsc.encode())
            self.oscRenderPre.append(renderGainOscs)

            channelSend = []
            for cId in range(self.globalConfig['number_direct_sends']):
                csOsc = '/source/' + str(i+1) + '/direct/' + str(cId)
                channelSend.append(csOsc.encode())
            self.oscDirectPre.append(channelSend)

            # self.posAddrs.append(sourceAddrs)

        self.validPosKeys = {skc.dist}

        self.isDataClient = True

        self.debugPrefix = "/dOscar"

    def myType(self) -> str:
        return 'Oscar'

    def sourcePositionChanged(self, source_idx):
        for key in skc.fullformat[self.posFormat]:
            self.updateStack[source_idx].add((partial(self.sources[source_idx].getPosition, key),
                                             (self.oscPosPre[source_idx][key],)))
            self.sourceChanged(source_idx)

    def sourceAttributeChanged(self, source_idx, attribute):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getAttribute[attribute]),
                                          (self.oscAttrPre[source_idx][attribute],)))
        self.sourceChanged(source_idx)

    def sourceDirectSendChanged(self, source_idx, send_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getDirectSend, send_idx),
                                          (self.oscDirectPre[source_idx][send_idx],)))
        self.sourceChanged(source_idx)

    def sourceRenderGainChanged(self, source_idx, render_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx),
                                          (self.oscRenderPre[source_idx][render_idx],)))
        self.sourceChanged(source_idx)

    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        osc_pre = args[0]
        return [(osc_pre, [values])]




class SeamlessPlugin(SpatialRenderer):
    def myType(self) -> str:
        return "Seamless Plugin"

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.xyz
        super(SeamlessPlugin, self).__init__(**kwargs)

        # self.basePort = 11000

        self.sourceAttributes = (skc.SourceAttributes.doppler, skc.SourceAttributes.planewave)

        self.oscAddrs: dict = {}

        # self.oscPosAddr = b"/source"

        for key in skc.fullformat[self.posFormat]:
            self.oscAddrs[key] = "/source/pos/{}".format(key).encode()

        for vv in self.sourceAttributes:
            self.oscAddrs[vv.value] = "/{}".format(vv.value).encode()

        self.oscAddrs['renderGain'] = "/send/gain".encode()



        self.debugPrefix = "/dSeamlessPlugin"


    # def updateSource(self, source_idx):
    #
    #     while self.updateStack[source_idx]:
    #         getValueFunc, oscPre = self.updateStack[source_idx].pop()
    #         values = getValueFunc()
    #
    #         msgs = self.composeSourceUpdateMessage(oscPre, values, source_idx)
    #         self.sendUpdates(msgs)
    #
    #     self.scheduleSourceUpdateCheck(source_idx)

    def composeSourceUpdateMessage(self, values, sIdx:int=0, *args) -> [(bytes, [])]:
        osc_pre = args[0]
        if osc_pre == self.oscAddrs['renderGain']:
            return [(osc_pre, [sIdx+1, args[1], values])]
        else:
            return [(osc_pre, [sIdx+1, values])]

    def sourceAttributeChanged(self, source_idx, attribute):
        pass

    def sourceRenderGainChanged(self, source_idx, render_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), (self.oscAddrs['renderGain'], render_idx)))
        self.sourceChanged(source_idx)

    def sourcePositionChanged(self, source_idx):
        for key in skc.fullformat[self.posFormat]:
            self.updateStack[source_idx].add((partial(self.sources[source_idx].getPosition, key), (self.oscAddrs[key],)))

        self.sourceChanged(source_idx)



class DataClient(Audiorouter, SpatialRenderer):
    pass


def createRendererClient(renderclass: renderclasstype, kwargs) -> Renderer:

    # config = reconf.getConfig(renderclass)
    # for key, value in config.items():
    #     if not key in kwargs.keys():
    #         kwargs[key] = value

    if 'dataformat' in kwargs.keys():
        tmp_dataFormat = kwargs['dataformat']
        if not tmp_dataFormat in skc.posformat.keys():
            # print(tmp_dataFormat)
            if len(tmp_dataFormat.split('_')) == 2:
                preStr = ''
                if tmp_dataFormat.split('_')[0] == 'normcartesian':
                    preStr = 'n'

                dFo = preStr + tmp_dataFormat.split('_')[1]
                kwargs['dataformat'] = dFo
            else:
                print('unknown position format')
                del(kwargs['dataformat'])
    if renderclass == renderclasstype.Wonder:
        rend = Wonder(**kwargs)
    elif renderclass == renderclasstype.Panoramix:
        rend = Panoramix(**kwargs)
    elif renderclass == renderclasstype.Oscar:
        rend = Oscar(**kwargs)
    elif renderclass == renderclasstype.Scengine:
        rend = SuperColliderEngine(**kwargs)
    elif renderclass == renderclasstype.SeamlessPlugin:
        rend = SeamlessPlugin(**kwargs)
    elif renderclass == renderclasstype.Audiorouter:
        rend = Audiorouter(**kwargs)
        return rend
    elif renderclass == renderclasstype.AudiorouterWFS:
        rend = AudiorouterWFS(**kwargs)

    else:
        rend = Renderer()


    return rend


