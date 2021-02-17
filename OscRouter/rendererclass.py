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


class Renderer(object):

    numberOfSources = 64
    sources: [SoundObject] = []
    globalConfig = {}
    debugCopy: bool = False
    oscDebugClient: OSCClient

    @classmethod
    def createDebugClient(cls, ip, port):
        cls.oscDebugClient = OSCClient(ip, port)

    def __init__(self, dataformat=skc.xyz,
                 updateintervall=10,
                 ipaddress='127.0.0.1',
                 listenport=4002,
                 continuously_update_intervall=-1,
                 renderid=-1,
                 sendport=0,
                 sourceattributes=()):

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

        self.multipleDestinations = False

        self.continous_update = self.continuously_update_intervall > 0

        self.toRender: [OSCClient] = []
        for idx, ip in enumerate(self.ipaddress):
            self.toRender.append(OSCClient(ip, self.listenport[0], encoding='utf8'))

        self.isDataClient = False

        self.printRenderInformation()

        # self.sources_updatecounter = 0

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

    def composeSourceUpdateMessage(self, osc_pre, values, sIdx:int=0) -> [(bytes, [])]:
        return [(osc_pre, values)]

    def sourceChanged(self, source_idx):
        if not self.source_getting_update[source_idx]:
            self.updateSource(source_idx)
        else:
            self.source_needs_update[source_idx] = True

    def updateSource(self, source_idx):

        while self.updateStack[source_idx]:
            getValueFunc, oscPre = self.updateStack[source_idx].pop()
            values = getValueFunc()
            msgs = self.composeSourceUpdateMessage(oscPre, values, source_idx)
            self.sendUpdates(msgs)

        self.scheduleSourceUpdateCheck(source_idx)

    def sendUpdates(self, msgs):
        print('sending updates', msgs)
        for msg in msgs:
            for toRenderClient in self.toRender:
                toRenderClient.send_message(msg[0], msg[1])

            if self.debugCopy:
                debugOsc = (self.debugPrefix + msg[0].decode()).encode()
                self.oscDebugClient.send_message(debugOsc, msg[1])

    def sendToDebugClient(self):
        pass

    def scheduleSourceUpdateCheck(self, source_idx):
        self.source_needs_update[source_idx] = False
        self.source_getting_update[source_idx] = True
        Timer(self.updateIntervall, partial(self.check_sourceNeedsUpdate, source_idx)).start()

    def check_sourceNeedsUpdate(self, source_idx):
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


class SpatialRenderer(Renderer):

    def myType(self) -> str:
        return 'Generic Spatial Renderer'

    def sourcePositionChanged(self, source_idx):
        print('got position change',self.myType(), source_idx)
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getPosition, self.posFormat),
                                          self.oscPre))
        self.sourceChanged(source_idx)

    def composeSourceUpdateMessage(self, osc_pre, values, sIdx:int=0) -> [(bytes, [])]:
        return [(osc_pre, values)]


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

        self.interpolTime = 1 / self.updateIntervall
        self.linkPositionAndAngle = True

        self.debugPrefix = "/dWonder"

    def myType(self) -> str:
        return 'Wonder'

    def sourceAttributeChanged(self, source_idx, attribute):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getAttribute, attribute),
                                          self.attributeOsc[attribute]))
        self.sourceChanged(source_idx)

    def composeSourceUpdateMessage(self, osc_pre, values, sIdx:int=0) -> [(bytes, [])]:

        wonderOscMap = {
            b'/WONDER/source/position': self.wonderPositionValues,
            b'/WONDER/source/angle': self.wonderAngleValues,
            b'/WONDER/source/dopplerEffect': self.wonderDopplerValues,
            b'/WONDER/source/type': self.wonderPlanewave
        }

        send_values = wonderOscMap[osc_pre](sIdx, values)

        return [(osc_pre, send_values)]

    def wonderPositionValues(self, sIdx:int, values) -> []:
        if self.linkPositionAndAngle and self.sources[sIdx].getAttribute(skc.SourceAttributes.planewave):
            self.addUpdateAngleToStack(sIdx)
        return [sIdx, *values, self.interpolTime]

    def wonderAngleValues(self, sIdx, values) -> []:
        #TODO: Umrechnen
        return [sIdx, *values, self.interpolTime]

    def wonderDopplerValues(self, sIdx, value) -> []:
        return [sIdx, value]

    def wonderPlanewave(self, sIdx, value) -> []:
        if value:
            self.addUpdateAngleToStack(sIdx)
        return [sIdx, int(not value)]

    def addUpdateAngleToStack(self, sIdx:int):
        self.updateStack[sIdx].add((partial(self.sources[sIdx].getPosition, skc.aed), self.oscAnglePref))


class Audiorouter(Renderer):
    #
    def __init__(self, **kwargs):
        super(Audiorouter, self).__init__(**kwargs)

        self.debugPrefix = "/dAudiorouter"
        self.oscpre_renderGain = b'/source/send/spatial'
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

    def updateSource(self, source_idx):

        while self.updateStack[source_idx]:
            getValueFunc, oscPre, secondIndex = self.updateStack[source_idx].pop()
            value = getValueFunc()
            msgs = self.composeSourceUpdateMessage(oscPre, value, source_idx, secondIndex)
            self.sendUpdates(msgs)

        self.scheduleSourceUpdateCheck(source_idx)

    def composeSourceUpdateMessage(self, osc_pre, values, sIdx:int=0, cIdx:int=0) -> [(bytes, [])]:
        return [(osc_pre, sIdx, cIdx, values)]

    def sourceDirectSendChanged(self, source_idx, send_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getDirectSend, send_idx), self.oscpre_directSend))
        self.sourceChanged(source_idx)

    def sourceRenderGainChanged(self, source_idx, render_idx):
        print('audiorouter', source_idx, render_idx)
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx), self.oscpre_renderGain))
        self.sourceChanged(source_idx)


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
        return 'Panoramix'

    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        # msgs = []
        sobject = self.sources[source_idx]
        position = sobject.getPosition(self.posFormat)
        # sourceID = source_idx + 1
        addr = self.posAddrs[source_idx]

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


    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        pass


class SuperColliderEngine(SpatialRenderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.aed
        super(SuperColliderEngine, self).__init__(**kwargs)

        self.oscPre = b'/source/aed'
        self.singleValKeys = {
            skc.azim: b'/source/azim',
            skc.dist: b'/source/dist',
            skc.elev: b'/source/elev'
        }
        self.validPosKeys = {skc.azim, skc.dist, skc.elev}

        self.debugPrefix = "/dSuperCollider"

    def composeSourceUpdateMessage(self, osc_pre, values, sIdx:int=0) -> [(bytes, [])]:

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

    def __init__(self, **kwargs):
        super(ViewClient, self).__init__(**kwargs)

        self.debugPrefix = "/dViewClient"


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
                                             self.oscPosPre[source_idx][key]))
            self.sourceChanged(source_idx)

    def sourceAttributeChanged(self, source_idx, attribute):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getAttribute[attribute]),
                                          self.oscAttrPre[source_idx][attribute]))
        self.sourceChanged(source_idx)

    def sourceDirectSendChanged(self, source_idx, send_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getDirectSend, send_idx),
                                          self.oscDirectPre[source_idx][send_idx]))
        self.sourceChanged(source_idx)

    def sourceRenderGainChanged(self, source_idx, render_idx):
        self.updateStack[source_idx].add((partial(self.sources[source_idx].getRenderGain, render_idx),
                                          self.oscRenderPre[source_idx][render_idx]))
        self.sourceChanged(source_idx)

    #
    # def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
    #     addrs = self.posAddrs[source_idx]
    #     posData = self.sources[source_idx].getPosition(self.posFormat)
    #
    #     msgs = []
    #
    #     for idx, key in enumerate(skc.fullformat[self.posFormat]):
    #         msgs.append((addrs[key], [posData[idx]]))
    #
    #     # for idx, addr in enumerate(addrs.values()):
    #     #     msgs.append((addr, [posData[idx]]))
    #
    #     return msgs
    #
    # def sendSourceAttributeMessage(self, sidx, attribute):
    #
    #     attriValue = self.sources[sidx].getSourceAttribute(attribute)
    #     for client in self.toRender:
    #         client.send_message(self.posAddrs[sidx][attribute], [attriValue])
    #
    #     # if attribute == skc.SourceAttributes.planewave:
    #     #     osc_str = b'/source/type'
    #     #     self.toRender.send_message(osc_str, [attriValue])
    #     # elif attribute == skc.SourceAttributes.doppler:
    #     #     osc_str = b'/source/dopplerEffect'
    #     #     self.toRender.send_message(osc_str, [attriValue])



class Osclight(SpatialRenderer):
    def myType(self) -> str:
        return "osc-light plugin"

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.nxyzd
        super(Osclight, self).__init__(**kwargs)

        self.basePort = 11000

        self.sourceAttributes = (skc.SourceAttributes.doppler, skc.SourceAttributes.planewave)

        self.oscAddrs: dict = {}

        self.oscPosAddr = b"/nxyz"

        for key in skc.fullformat[self.posFormat]:
            self.oscAddrs[key] = "/{}".format(key).encode()

        for vv in self.sourceAttributes:
            self.oscAddrs[vv.value] = "/{}".format(vv.value).encode()


        self.oscClients: [OSCClient] = []
        for x in range(self.numberOfSources):
            self.oscClients.append(OSCClient(self.ipaddress, port=self.basePort+x))

        self.debugPrefix = "/dOscLight"


    def sendSourcePosition(self, source_idx):
        msgs = self.composeSourceUpdateMessage(source_idx)

        for addr, data in msgs:
            # oscsock.send_message(addr, data, ip_address=self.ipaddress, port=self.basePort+source_idx)
            self.oscClients[source_idx].send_message(addr, data)

        if self.debugCopy:
            for addr, data in msgs:
                self.oscDebugSend(addr, data)


    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        # msgs = []
        posData = self.sources[source_idx].getPosition[self.posFormat]

        # for idx,key in enumerate(skc.fullformat[self.posFormat]):
        #     msgs.append((self.oscAddrs[key], posData[idx]))

        return [self.oscPosAddr, posData]

        # oscsock.send_message(b"/beepbepp", [], self.ipaddress, port=123)


    def sendSourceAttributeMessage(self, sidx, attribute):
        pass


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
    elif renderclass == renderclasstype.Audiorouter:
        rend = Audiorouter(**kwargs)
    elif renderclass == renderclasstype.Osclight:
        rend = Osclight(**kwargs)
    else:
        rend = Renderer()

    return rend
