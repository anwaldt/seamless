from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer

from functools import partial
import numpy as np

import conversionsTools as ct

# from tochOscCommunication import TouchOscCommunicatior

from soundobjectclass import SoundObject

soundObjectsData_local: list[SoundObject] = []
soundObjectsData_remote: list[SoundObject] = []
globalConfig = {}

class LocalOscrouter:

    def __init__(self, config, remoteIp='127.0.0.1'):

        global globalConfig
        globalConfig = config

        self.listeningPort = 55405
        self.remoteOscRouter_ip = remoteIp#'127.0.0.1'

        self.oscServer = OSCThreadServer()
        self.oscServer.listen('0.0.0.0', self.listeningPort, default=True)

        self.oscClient = OSCClient(self.remoteOscRouter_ip, 4999)

        self.subscriptionName = 'productionClient'

        SoundObject.readGlobalConfig(config)
        # self.soundObjectsData: list[SoundObject] = []
        self.createSoundObjects()

        self.touchOscClient = TouchOscCommunicatior(self, 55510, 55511)
        self.seamlessPluginClient = SeamlessPluginCommunicator(self, 55530, 55531)


    def initSubscription(self):
        self.oscClient.send_message(b'/oscrouter/subscribe', [self.subscriptionName, self.listeningPort, 'xyz', 1, 10])

    def oscR_receivedPing(self, *args):
        try:
            _remoteIP = args[0].decode()
            if not _remoteIP == self.oscClient.address:
                self.oscClient.address = _remoteIP
        except:
            pass

        self.oscClient.send_message(b'(oscrouter/pong', [self.subscriptionName])

    def setupOscBindings(self):
        self.oscServer.bind(b'/oscrouter/ping', self.oscR_receivedPing)

    def createSoundObjects(self):

        for i in range(globalConfig['number_sources']):
            soundObjectsData_local.append(SoundObject(i + 1))
            soundObjectsData_remote.append(SoundObject(i + 1))


class CommunicationClients:

    def __init__(self, localRouter, listeningPort, sendPort, remoteIp='127.0.0.1'):
        self.localRouter = localRouter
        self.listeningPort = listeningPort
        self.sendPort = sendPort

        self.oscServer = OSCThreadServer(timeout=0.005)
        self.oscServer.listen('0.0.0.0', self.listeningPort, default=True)
        self.oscClient = OSCClient(remoteIp, sendPort)

        self.clientName = 'generic'

        # self.greetingMessage()


    def greetingMessage(self):
        print('{} client: \n\t on Client set send-port to {} and receive-port to {}'.format(self.clientName, self.listeningPort, self.sendPort))


class TouchOscCommunicatior(CommunicationClients):

    oscPre_uiPos = {
        'xy': [b'/pos/xy', b'/label/x', b'/label/y'],
        'z': [b'/pos/z', b'/label/z'],
        'azim': [b'/pos/azim', b'/label/azim'],
        'elev': [b'/pos/elev', b'/label/elev'],
        'dist': [b'/pos/dist', b'/label/dist']
    }
    oscPre_uiSourceSelect = []
    oscPre_uiSourceLink = []
    oscPre_uiSelectedLabel = b'/label/selected'
    oscPre_uiFollowerXy = []

    oscPre_setGain = {
        'wfs': [b'/gain/wfs', b'/label/wfs'],
        'ambi': [b'/gain/ambi', b'/label/ambi'],
        'reverb': [b'/gain/reverb', b'/label/reverb']
    }
    gainKeyMap = {
        'wfs': 1,
        'ambi': 0,
        'reverb': 2
    }

    def __init__(self, *args):
        super(TouchOscCommunicatior, self).__init__(*args)
        self.clientName = 'TouchOsc'
        self.greetingMessage()

        self.touchOscConnected = False
        self.numSourcesInInterface = 18
        self.uiElementTouchstate = {
            'xy': False,
            'z': False,
            'dist': False,
            'azim': False,
            'elev': False
        }
        self.anyUiTouched = False

        self.lastTouchValues = {
            'xy': np.array([0, 0]),
            'z': np.array([0]),
            'dist': np.array([0]),
            'azim': np.array([0]),
            'elev': np.array([0])
        }


        self.selectedSourceIndex = 0
        self.additionalSelectedSources = []
        self.sourceFollower = [-1]*self.numSourcesInInterface
        self.linkState = [False]*self.numSourcesInInterface



        self.setupOscBindings()

        # self.greetingMessage()

    # def differentialSourceUpdate(self, key, diffValues):
    #     pass

    def updateAllUiElements(self):
        self.updatePositionUiElements()
        self.updateAllGainsForSelectedSource()

    def updatePositionUiElements(self):
        for uiKey, touched in self.uiElementTouchstate.items():
            # if not uiKey == exceptUi:

            values = soundObjectsData_local[self.selectedSourceIndex].getPosition(uiKey)

            if not uiKey == 'xy':
                if not touched:
                    self.oscS_sendOscMessage(self.oscPre_uiPos[uiKey][0], [values])
                self.oscS_sendOscMessage(self.oscPre_uiPos[uiKey][1], [round(values, 2)])
            else:
                if not touched:
                    self.oscS_sendOscMessage(self.oscPre_uiPos[uiKey][0], values)
                self.oscS_sendOscMessage(self.oscPre_uiPos[uiKey][1], [round(values[0], 2)])
                self.oscS_sendOscMessage(self.oscPre_uiPos[uiKey][2], [round(values[1], 2)])


    def oscR_positionUpdate(self, uiKey, *args):
        # print('Position update', uiKey, args)
        _tState = bool(args[-1])
        if _tState:
            if not self.uiElementTouchstate[uiKey]:
                self.setTouchStateForUiElement(uiKey, True)#True#bool(args[-1])
                self.lastTouchValues[uiKey] = np.array(args[0:-1])

            touchInputValues = np.array(args[0:-1])

            difValues = touchInputValues - self.lastTouchValues[uiKey]

            self.sourceDifferentialUpdate(self.selectedSourceIndex, uiKey, difValues)
            self.updatePositionUiElements()
            self.updateSourceGroup(self.selectedSourceIndex, uiKey, difValues)

            self.lastTouchValues[uiKey] = touchInputValues

            self.updatePositionUiElements()

        else:
            self.setTouchStateForUiElement(uiKey, False)


    def updateSourceGroup(self, sIdx, key, difValues):

        for i, _sidx in enumerate(self.additionalSelectedSources):
            self.sourceDifferentialUpdate(_sidx, key, difValues)
            newXy = soundObjectsData_local[_sidx].getPosition('xy')
            if i < 5:
                self.oscS_sendOscMessage(self.oscPre_uiFollowerXy[i], newXy)
        # _follow = self.sourceFollower[sIdx]
        # if _follow > -1:
        #     self.updateFollower(sIdx, _follow, key, difValues, 0)

    def updateFollower(self, sIdx, followIdx, key, difValues, counter):
        if not sIdx == followIdx:
            self.sourceDifferentialUpdate(followIdx, key, difValues)
            newXy = soundObjectsData_local[followIdx].getPosition('xy')
            if counter < 5:
                self.oscS_sendOscMessage(self.oscPre_uiFollowerXy[counter], newXy)
            _follow = self.sourceFollower[followIdx]
            if _follow > -1:
                self.updateFollower(sIdx, _follow, key, difValues, counter+1)

    def updateFollowerForSelection(self, sIdx, followIdx, counter=0):
        if not followIdx == sIdx:
            _xy = soundObjectsData_local[followIdx].getPosition('xy')
            self.oscS_sendOscMessage(self.oscPre_uiFollowerXy[counter], _xy)
            if self.sourceFollower[followIdx] > -1 and counter < len(self.oscPre_uiFollowerXy)-1:
                self.updateFollowerForSelection(sIdx, self.sourceFollower[followIdx], counter+1)



    valueCheckFunctions = {
        'xy': partial(np.clip, a_min=-10, a_max=10),
        'z':partial(np.clip, a_min=-10, a_max=10),
        'azim': ct.wrapAzimuth180,
        'elev': ct.wrapElevation90,
        'dist': partial(np.clip, a_min=0.1, a_max=14)
    }

    def sourceDifferentialUpdate(self, sIdx, key, difValues) -> bool:
        _sObject = soundObjectsData_local[sIdx]
        oldSourcePos = _sObject.getPosition(key)
        newSourcePos = oldSourcePos + difValues

        newSourcePos = self.valueCheckFunctions[key](newSourcePos)

        return _sObject.setPosition(key, *newSourcePos)


    def setTouchStateForUiElement(self, uiKey, bValue:bool):
        self.uiElementTouchstate[uiKey] = bValue
        self.checkUiTouched()


    def checkUiTouched(self) -> bool:
        _touched = 0
        for i in self.uiElementTouchstate.values():
            _touched += i
        return bool(_touched)

    def checkConnected(self) -> bool:
        return False


    def oscR_sourceSelect(self, *args, sIdx=0):

        _oldSelection = self.selectedSourceIndex
        self.selectedSourceIndex = sIdx
        self.updateAllUiElements()
        if args[0] == 0:
            self.oscS_sendOscMessage(self.oscPre_uiSourceSelect[sIdx], [1.])
        else:
            self.setGroupSelection()
            for i in range(self.numSourcesInInterface):
                if not i == sIdx:
                    self.oscS_sendOscMessage(self.oscPre_uiSourceSelect[i], [0.])


    def oscR_autoWrite(self, *args, sIdx):
        pass

    def oscR_setGain(self, *args, key='ambi'):
        soundObjectsData_local[self.selectedSourceIndex].setRendererGain(self.gainKeyMap[key], args[0])
        self.setGainForSourceGroup(key, args[0])
        self.updateGainForSelectedSource(key, args[0], bool(args[1]))
        # soundObjectsData_local[self.selectedSourceIndex]
    def updateGainForSelectedSource(self, key, value, faderLocked=False):
        self.oscS_sendOscMessage(self.oscPre_setGain[key][1], [round(value, 2)])
        if not faderLocked:
            self.oscS_sendOscMessage(self.oscPre_setGain[key][0], [value])

    def updateAllGainsForSelectedSource(self):
        for key in ['wfs', 'ambi', 'reverb']:
            gain = soundObjectsData_local[self.selectedSourceIndex].getRenderGain(self.gainKeyMap[key])
            self.updateGainForSelectedSource(key, gain)

    def setGainForSourceGroup(self, key, value):
        for i in self.additionalSelectedSources:
            soundObjectsData_local[i].setRendererGain(self.gainKeyMap[key], value)

    def oscR_sourceLink(self, *args, sIdx=0):

        _linkIt = bool(args[0])

        self.linkState[sIdx] = _linkIt
        self.setFollowerIndices()

        self.setGroupSelection()
        # print('selected sources', self.additionalSelectedSources)
        # print('source follower', self.sourceFollower)


    def setGroupSelection(self):
        self.additionalSelectedSources = []
        _follower = self.sourceFollower[self.selectedSourceIndex]
        while not _follower == self.selectedSourceIndex and _follower > -1:
            self.additionalSelectedSources.append(_follower)
            _follower = self.sourceFollower[_follower]
        # if self.sourceFollower[self.]

    def setFollowerIndices(self):
        _firstInGroup = -1
        for i in range(self.numSourcesInInterface):
            if self.linkState[i]:
                if i < self.numSourcesInInterface-1:
                    self.sourceFollower[i] = i+1
                if _firstInGroup < 0:
                    _firstInGroup = i
            else:
                if _firstInGroup > -1:
                    self.sourceFollower[i] = _firstInGroup

                    _firstInGroup = -1
                else:
                    self.sourceFollower[i] = -1


    def oscR_pluginSendActive(self, *args):
        pass

    def oscR_connectionRequest(self, *args):
        sender_info = self.oscServer.get_sender()
        self.oscClient = OSCClient(sender_info[1], sender_info[2])
        self.touchOscConnected = True

        self.updateAllUiElements()
        for i in range(self.numSourcesInInterface):#self.linkState:
            # print('link', i)

            sVal = int(self.linkState[i])
            self.oscS_sendOscMessage(self.oscPre_uiSourceLink[i], [sVal])


    def oscS_sendOscMessage(self, oscPre, values):
        if self.touchOscConnected:
            try:
                # print('sending Message', oscPre, values)
                self.oscClient.send_message(oscPre, values)
            except:
                print('message send fail')
                self.touchOscConnected = False


    def setupOscBindings(self):
        for sIdx in range(self.numSourcesInInterface):
            _oscPreSel = '/select/{}'.format(sIdx + 1).encode()
            self.oscPre_uiSourceSelect.append(_oscPreSel)
            self.oscServer.bind(_oscPreSel, partial(self.oscR_sourceSelect, sIdx=sIdx))

            _oscPreLink = '/link/{}'.format(sIdx + 1).encode()

            self.oscPre_uiSourceLink.append(_oscPreLink)
            self.oscServer.bind(_oscPreLink, partial(self.oscR_sourceLink, sIdx=sIdx))

        # print(self.oscPre_uiSourceLink)
        for key, osc in self.oscPre_uiPos.items():
            self.oscServer.bind(osc[0], partial(self.oscR_positionUpdate, key))

        for i in range(6):
            self.oscPre_uiFollowerXy.append('/xy{}'.format(i).encode())

        for key, _oscPre in self.oscPre_setGain.items():
            self.oscServer.bind(_oscPre[0], partial(self.oscR_setGain, key=key))

        self.oscServer.bind(b'/connect/touch', self.oscR_connectionRequest)



class SeamlessPluginCommunicator(CommunicationClients):

    def __init__(self, *args):
        super(SeamlessPluginCommunicator, self).__init__(*args)
        self.clientName = 'Seamless Plugin'
        self.greetingMessage()



class SpatSourceViewer(CommunicationClients):

    def __init__(self, *args):

        super(SpatSourceViewer, self).__init__(*args)
        self.clientName = 'Spat Viewer'
        self.greetingMessage()



class ReaperOscCommunicator(CommunicationClients):

    def __init__(self, *args):
        super(ReaperOscCommunicator, self).__init__(*args)
        self.clientName = 'Reaper Com'
        self.greetingMessage()