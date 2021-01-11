# import renderer_config as reconf
from soundobjectclass import SoundObject
import str_keys_conventions as skc
from str_keys_conventions import renderClass as renderclass
import conversionsTools as ct
from oscpy.client import OSCClient
import time
from threading import Timer
from functools import partial
from sched import scheduler
# from enum import Enum


class Renderer(object):

    numberOfSources = 64
    sources: [SoundObject] = []
    globalConfig = {}

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
        self.ipaddress = ipaddress
        self.listenport = int(listenport)
        self.updateIntervall = int(updateintervall) / 1000
        self.continuously_update_intervall = int(continuously_update_intervall)

        self.source_needs_update = [False] * self.numberOfSources
        self.source_getting_update = [False] * self.numberOfSources

        # self.sourceAttributes_needsUpdate = [''] * self.numberOfSources

        # For renderer that want continous updates
        self.continous_update = self.continuously_update_intervall > 0

        self.toRender = OSCClient(self.ipaddress, self.listenport, encoding='utf8')
        self.sCheckSchedule = scheduler(time.time, time.sleep)

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
        # print(self.myType(), 'renderID:', self.renderid, '\n',
        #       'address:', self.ipaddress, 'listenport:', self.listenport, '\n',
        #       'listening to format', self.posFormat, '\n')

    def myType(self) -> str:
        return 'basic Rendererclass'

    def scheduleSourcePositionCheck(self, source_idx):

        check = partial(self.check_sourceNeedsPositionUpdate, source_idx)
        # print(self.updateIntervall)
        Timer(self.updateIntervall, check).start()

        freshstart = self.sCheckSchedule.empty()
        # #print('Freshstart: ', str(freshstart))
        # self.sCheckSchedule.enter(self.updateIntervall, 1, check)
        # if freshstart:
        #     self.sCheckSchedule.run()

    def check_sourceNeedsPositionUpdate(self, source_idx):
        # print('source Check position on source ', str(source_idx))
        if self.source_needs_update[source_idx]:
            self.updateSourcePosition(source_idx)
        else:
            self.source_getting_update[source_idx] = False


    def updateSourcePosition(self, source_idx):
        print('update position', source_idx, self.myType())

        self.sendSourcePosition(source_idx)
        self.source_needs_update[source_idx] = False
        self.source_getting_update[source_idx] = True
        self.scheduleSourcePositionCheck(source_idx)


    def sendSourcePosition(self, source_idx):

        msgs = self.composeSourceUpdateMessage(source_idx)
        print(msgs)
        for addr, data in msgs:
            self.toRender.send_message(addr, data)


    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:

        sobject = self.sources[source_idx]
        posData = sobject.getPosition(self.posFormat)
        sourceID = source_idx + 1
        posData.insert(0, sourceID)
        return list([('/source/pos/'+self.posFormat, posData)])

    def setContinousUpdateIntervall(self, update):

        self.continuously_update_intervall = update
        self.continous_update = update > 0


    def sourceNeedsUpdate(self, source_idx):

        self.source_needs_update[source_idx] = True
        if not self.source_getting_update[source_idx]:
            self.updateSourcePosition(source_idx)


    def sourceAttributeChanged(self, source_idx, attribute):
        if attribute in self.sourceAttributes:
            self.sendSourceAttributeMessage(source_idx, attribute)


    def sendSourceAttributeMessage(self, sidx, attribute):
        pass

    # for an even temporal distribution of source updates?
    def getTimeroffset(self) -> float:
        return 0

    def getSceneData(self):
        for idx in range(len(self.sources)):
            self.sendSourcePosition(idx)




class Wonder(Renderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.xy
        if not 'sourceattributes' in kwargs.keys():
            kwargs['sourceattributes'] = (skc.SourceAttributes.doppler, skc.SourceAttributes.planewave)
        super(Wonder, self).__init__(**kwargs)

    def myType(self) -> str:
        return 'Wonder'

    def composeSourceUpdateMessage(self, source_idx: int) -> [(str, [])]:
        msgs = []
        sobject: SoundObject = self.sources[source_idx]
        position = sobject.getPosition(skc.xy)
        position = ct.apply_factor_addition(position, [0, -1], [0, 3])
        addr = '/WONDER/source/pos'
        msgs.append([addr, [source_idx, *position, self.updateIntervall]])

        if sobject.getSourceAttribute(skc.SourceAttributes.planewave):
            angle_addr = '/WONDER/source/angle'
            sobj_azim = sobject.getPosition(skc.azim)
            angle = ct.azi_to_wonderangle(sobj_azim)
            msgs.append([angle_addr, [source_idx, angle, self.updateIntervall]])

        return msgs

    def sendSourceAttributeMessage(self, sidx, attribute):

        attriValue = self.sources[sidx].getSourceAttribute(attribute)

        if attribute == skc.SourceAttributes.planewave:
            osc_str = b'/source/type'
            self.toRender.send_message(osc_str, [attriValue])
        elif attribute == skc.SourceAttributes.doppler:
            osc_str = b'/source/dopplerEffect'
            self.toRender.send_message(osc_str, [attriValue])



class Panoramix(Renderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.xyz
        super(Panoramix, self).__init__(**kwargs)

        self.posAddrs = [''] * self.numberOfSources
        for i in range(self.numberOfSources):
            self.posAddrs[i] = '/track/' + str(i+1) + '/xyz'

    def myType(self) -> str:
        return 'Panoramix'

    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        # msgs = []
        sobject = self.sources[source_idx]
        position = sobject.getPosition(self.posFormat)
        # sourceID = source_idx + 1
        addr = self.posAddrs[source_idx]

        return [(addr, position)]



class IemMultiencoder(Renderer):

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


    def myType(self) -> str:
        return 'IEM Multiencoder, carfeul not implemented'


    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        pass

class SuperColliderEngine(Renderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.aed
        super(SuperColliderEngine, self).__init__(**kwargs)

        self.addrstr = '/source/aed'
        self.singleValKeys = {
            skc.azim: '/source/azim',
            skc.dist: '/source/dist',
            skc.elev: '/source/elev'
        }
        self.validPosKeys = {skc.azim, skc.dist, skc.elev}

    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        sobject = self.sources[source_idx]
        singleUpdate = sobject.getSingleValueUpdate(self.validPosKeys)
        if singleUpdate:
            return [(self.singleValKeys[singleUpdate[0]]), [singleUpdate[1]]]

        else:
            position = sobject.getPosition(self.posFormat)
            return [(self.addrstr, [source_idx + 1, *position])]


    def myType(self) -> str:
        return 'Supercolliderengine'


class Audiorouter(Renderer):

    def myType(self) -> str:
        return 'Audiorouter'

    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:

        msgs: [(str, [])] = []
        addStr = '/send/gain/individual'
        sobject = self.sources[source_idx]

        for idx, gain in sobject.getChangedGains():
            msgs.append((addStr, [source_idx, idx, gain]))

        return msgs

        # for ridx, gain in enumerate(sobject.getAllRendererGains()):
        #     msgs.append((addStr, [ridx, source_idx, gain]))
        # # print('Gains', msgs)
        # return msgs


class ViewClient(Renderer):

    def __init__(self, **kwargs):
        super(ViewClient, self).__init__(**kwargs)


    #TODO: send complete Scene data


class Oscar(Renderer):

    def __init__(self, **kwargs):
        if not 'dataformat' in kwargs.keys():
            kwargs['dataformat'] = skc.nxyzd
        super(Oscar, self).__init__(**kwargs)

        self.posAddrs = []
        for i in range(self.numberOfSources):
            sourceAddrs = {}
            for kk in skc.fullformat[skc.nxyzd]:
                addrStr = '/source/' + str(i+1) + '/pos/' + kk
                sourceAddrs[kk] = addrStr
            self.posAddrs.append(sourceAddrs)

        self.validPosKeys = {skc.dist}

    def myType(self) -> str:
        return 'Oscar'


    def composeSourceUpdateMessage(self, source_idx) -> [(str, [])]:
        addrs = self.posAddrs[source_idx]
        posData = self.sources[source_idx].getPosition(self.posFormat)

        msgs = []
        for idx, addr in enumerate(addrs.values()):
            msgs.append((addr, [posData[idx]]))

        return msgs


def createRendererClient(renderclass: renderclass, kwargs) -> Renderer:

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



    if renderclass == renderclass.Wonder:
        rend = Wonder(**kwargs)
    elif renderclass == renderclass.Panoramix:
        rend = Panoramix(**kwargs)
    elif renderclass == renderclass.Oscar:
        rend = Oscar(**kwargs)
    elif renderclass == renderclass.Scengine:
        rend = SuperColliderEngine(**kwargs)
    elif renderclass == renderclass.Audiorouter:
        rend = Audiorouter(**kwargs)
    else:
        rend = Renderer()

    return rend
