from oscpy.client import OSCClient
from oscpy.server import OSCThreadServer

from functools import partial
import numpy as np

import conversionsTools as ct

from threading import Timer
from time import time

# from tochOscCommunication import TouchOscCommunicatior

from soundobjectclass import SoundObject

soundObjectsData_local: list[SoundObject] = []# : list[SoundObject] = []
soundObjectsData_remote: list[SoundObject] = []
globalConfig = {}

class LocalOscrouter:

    uiElements = {'xy', 'z', 'azim', 'elev', 'dist', 'x', 'y'}
    oscPre_sourcePositions = []
    oscPre_sourceGain = []
    rIdxToSystem = {
        0: 'ambi',
        1: 'wfs',
        2: 'reverb'
    }
    systemToRIdx = {
        'ambi': 0,
        'wfs': 1,
        'reverb': 2
    }
    # for elem in uiElements

    def __init__(self, config, remoteIp='127.0.0.1', autosubscribe=True, pluginAddress='127.0.0.1'):

        global globalConfig
        globalConfig = config

        self.autoScubscribe = autosubscribe

        self.listeningPort = 55405
        self.remoteOscRouter_ip = remoteIp#'127.0.0.1'

        self.oscServer = OSCThreadServer()
        self.oscServer.listen('0.0.0.0', self.listeningPort, default=True)
        self.setupOscBindings()

        self.oscClient = OSCClient(self.remoteOscRouter_ip, 4455)
        self.oscClient_settings = OSCClient(self.remoteOscRouter_ip, 4999)

        self.subscriptionName = 'productionClient'

        SoundObject.readGlobalConfig(config)
        # self.soundObjectsData: list[SoundObject] = []
        self.createSoundObjects()

        self.remoteOscRouterConnected = False
        self.waitingForPing = False
        self.routerSearching = False
        self.lastPing = time()

        self.sendFromPlugin = True

        self.touchOscClient = TouchOscCommunicatior(self, 55510, 55511)
        self.seamlessPluginClient = SeamlessPluginCommunicator(self, 55530, 55531, remoteIp=pluginAddress)
        self.spatViewerClient = SpatSourceViewer(self, 55550, 55551)
        self.reaperControlClient = ReaperOscCommunicator(self, 55540, 55541)

        self.touchedSources = []
        self.touchedSourceGains = []

        self.createSourcePositionOscPres()
        if self.autoScubscribe:
            self.initSubscription()


    def createSourcePositionOscPres(self):
        for i in range(globalConfig['number_sources']):
            self.oscPre_sourcePositions.append({})
            self.oscPre_sourceGain.append({})
            for _elem in self.uiElements:
                _oscPre = '/source/{}/{}'.format(i+1, _elem)
                self.oscPre_sourcePositions[i][_elem] = _oscPre.encode()
            for _rend in ['wfs', 'ambi', 'reverb']:
                _oscPre = '/source/{}/{}'.format(i+1, _rend)
                self.oscPre_sourceGain[i][_rend] = _oscPre.encode()

    def oscS_sendMessageToRouterSettings(self, oscPre, values):
        if self.remoteOscRouterConnected:
            try:
                self.oscClient_settings.send_message(oscPre, values)
            except:
                self.remoteOscRouterConnected = False

    def oscS_sendMessageToRouterUi(self, oscPre, values):
        if self.remoteOscRouterConnected or not self.autoScubscribe:
            # print('sending position', oscPre, values)
            try:
                self.oscClient.send_message(oscPre, values)
            except:
                print('failure in sending to ui')
                self.remoteOscRouterConnected = False

    def initSubscription(self, force=False):
        # print('subscription connected', self.remoteOscRouterConnected)
        if not self.remoteOscRouterConnected or force:
            if not self.routerSearching:
                self.routerSearching = True
                print('looking for remote OSC-Router...')
            try:
                print('sending subscribe request to', self.oscClient_settings.address, self.oscClient_settings.port, [self.subscriptionName, self.listeningPort, 'xyz', 1, 10])
                self.oscClient_settings.send_message(b'/oscrouter/subscribe', [self.subscriptionName.encode(), self.listeningPort, b'xyz', 1, 20])
            except:
                pass
            Timer(4, self.initSubscription).start()


    def oscR_receivedPing(self, *args):
        # print('oscr received Ping')
        try:
            _remoteIP = args[0].decode()
            if not _remoteIP == self.oscClient.address:
                self.oscClient.address = _remoteIP
        except:
            pass

        self.lastPing = time()
        if not self.remoteOscRouterConnected:
            self.remoteOscRouterConnected = True
            print('remote OSC-Router connected')
            self.routerSearching = False
            self.checkConnectionState()

        self.touchOscClient.sendRouterPingMessage()
        self.oscS_sendMessageToRouterSettings(b'/oscrouter/pong', [self.subscriptionName.encode()])
        # self.touchOscClient.

    def checkConnectionState(self):
        print('last ping', time()-self.lastPing)
        if self.remoteOscRouterConnected:
            if time() - self.lastPing > 8:
                print('connection lost')
                self.remoteOscRouterConnected = False
                self.initSubscription()
            else:
                self.remoteOscRouterConnected = True
                # self.lastPing = time()
                Timer(4500, self.checkConnectionState).start()
        else:
            # print('someone set connected false')
            self.initSubscription()

    def setupOscBindings(self):
        self.oscServer.bind(b'/oscrouter/ping', self.oscR_receivedPing)
        for i in range(globalConfig['number_sources']):
            _oscPre = '/source/{}/xyz'.format(i)
            self.oscServer.bind(_oscPre.encode(), partial(self.oscR_receivePositionFromRouter, oscPre=_oscPre.encode()))

    def createSoundObjects(self):
        for i in range(globalConfig['number_sources']):
            soundObjectsData_local.append(SoundObject(i + 1))
            soundObjectsData_remote.append(SoundObject(i + 1))

    def sendPositionUpdatesFromTouch(self, sIdx, key, values):
        _oscPre = self.oscPre_sourcePositions[sIdx][key]
        self.sendUpdatesFromTouchClient(_oscPre, values)
        self.seamlessPluginClient.oscS_sendPositionToPlugin(sIdx, key, values)

    def sendGainUpdatesFromTouch(self, sIdx, key, value):
        # _oscPre = self.oscPre_sourceGain[sIdx][key]
        # print('sendgains',self.oscPre_sourceGain[sIdx][key], [value] )
        self.sendUpdatesFromTouchClient(self.oscPre_sourceGain[sIdx][key], [value])
        self.seamlessPluginClient.oscS_sendGainToPlugin(sIdx,key,value)

    def sendUpdatesFromTouchClient(self, oscPre, values):
        # if self.sendFromPlugin:
        #     pass
        # else:
            # print('sending position', oscPre, values)
        self.oscS_sendMessageToRouterUi(oscPre, values)

    def sendPositionUpdatesFromSeamlessClient(self, sIdx, key, value):

        _oscPre = self.oscPre_sourcePositions[sIdx][key]
        self.oscS_sendMessageToRouterUi(_oscPre, [value])
        if self.touchOscClient.selectedSourceIndex == sIdx:
            self.touchOscClient.updatePositionUiElements()

    def sendGainUpdatesFromSeamlessClient(self, sIdx, rIdx, value):
        _system = self.rIdxToSystem[rIdx]
        _oscPre = self.oscPre_sourceGain[sIdx][_system]
        self.oscS_sendMessageToRouterUi(_oscPre, [value])
        if self.touchOscClient.selectedSourceIndex == sIdx:
            self.touchOscClient.updateGainForSelectedSource(_system, value)


    def oscR_receivePositionFromRouter(self, *args, oscPre=b'/source/1/xyz'):
        # print('received postion', args)
        self.spatViewerClient.oscS_forwardPositionMessage(args, oscPre)


class CommunicationClients:

    def __init__(self, localRouter, listeningPort, sendPort, remoteIp='127.0.0.1'):#, clientIp='127.0.0.1'):
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
    oscPre_touchPing = b'/touch/ping'
    oscPre_routerPing = b'/router/ping'

    oscPre_autoWriteReaper = []

    def __init__(self, *args):
        super(TouchOscCommunicatior, self).__init__(*args)
        self.clientName = 'TouchOsc'
        self.greetingMessage()

        self.touchOscConnected = False
        self.numSourcesInInterface = 32
        self.uiElementTouchstate = {
            'xy': False,
            'z': False,
            'dist': False,
            'azim': False,
            'elev': False
        }
        self.anyUiTouched = False

        self.faderElementsTouchstate = {
            'ambi': False,
            'wfs': False,
            'reverb': False
        }

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

        self.touchPingToggle = 0
        self.routerPingToggle = 0

        self.positionUpdates = set()

        self.setupOscBindings()

        # self.greetingMessage()

    # def differentialSourceUpdate(self, key, diffValues):
    #     pass

    def updateAllUiElements(self):
        self.updatePositionUiElements()
        self.updateAllGainsForSelectedSource()
        for i in range(self.numSourcesInInterface):#self.linkState:
            # print('link', i)

            sVal = int(self.linkState[i])
            self.oscS_sendOscMessage(self.oscPre_uiSourceLink[i], [sVal])

            self.oscS_sendOscMessage(self.oscPre_uiSourceSelect[i], [int(i==self.selectedSourceIndex)])

        self.oscS_sendOscMessage(b'/pluginsend', [int(self.localRouter.sendFromPlugin)])


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

            self.notifyRouterForSourcePositionUpdate()

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


    def notifyRouterForSourcePositionUpdate(self):
        while self.positionUpdates:
            _update = self.positionUpdates.pop()
            self.localRouter.sendPositionUpdatesFromTouch(*_update)

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

        self.positionUpdates.add((sIdx, key, (*newSourcePos,)))

        return _sObject.setPosition(key, *newSourcePos)


    def setTouchStateForUiElement(self, uiKey, bValue:bool):
        self.uiElementTouchstate[uiKey] = bValue
        self.anyUiTouched = self.checkUiTouched(self.uiElementTouchstate)
        if self.anyUiTouched:
            self.localRouter.touchedSources = [self.selectedSourceIndex, *self.additionalSelectedSources]
        else:
            self.localRouter.touchedSources = []
        # print('any touch', self.anyUiTouched)

    def setTouchStateForFader(self):
        pass


    def checkUiTouched(self, uiSet) -> bool:
        _touched = 0
        for i in uiSet.values():
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
        # print('gain touched', args)
        soundObjectsData_local[self.selectedSourceIndex].setRendererGain(self.gainKeyMap[key], args[0])
        self.setGainForSourceGroup(key, args[0])
        self.updateGainForSelectedSource(key, args[0], bool(args[1]))
        for i in [self.selectedSourceIndex, *self.additionalSelectedSources]:
            self.localRouter.sendGainUpdatesFromTouch(i, key, args[0])

        self.faderElementsTouchstate[key] = bool(args[-1])
        if self.checkUiTouched(self.faderElementsTouchstate):
            self.localRouter.touchedSourceGains = [self.selectedSourceIndex, *self.additionalSelectedSources]
        else:
            self.localRouter.touchedSourceGains = []

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

        self.localRouter.sendFromPlugin = bool(args[0])
        print('plugin send', self.localRouter.sendFromPlugin)

    def oscR_connectionRequest(self, *args):

        self.localRouter.touchedSources = []
        self.localRouter.touchedSources = []

        sender_info = self.oscServer.get_sender()
        self.oscClient = OSCClient(sender_info[1], sender_info[2])
        if not self.touchOscConnected:
            _startPing = True
        else:
            _startPing = False
        self.touchOscConnected = True

        if _startPing:
            self.sendTouchPingMessage()

        self.updateAllUiElements()


    def sendTouchPingMessage(self):
        self.touchPingToggle = int(not self.touchPingToggle)
        self.oscS_sendOscMessage(self.oscPre_touchPing, [self.touchPingToggle])
        if self.touchOscConnected:
            if self.touchPingToggle:
                Timer(0.2, self.sendTouchPingMessage).start()
            else:
                Timer(2, self.sendTouchPingMessage).start()


    def oscR_connectToRoute(self, *args):
        print('connect router')
        self.localRouter.initSubscription(force=True)

    def sendRouterPingMessage(self, _on=True):
        self.oscS_sendOscMessage(self.oscPre_routerPing, [_on])
        if _on:
            Timer(0.2, partial(self.sendRouterPingMessage, 0)).start()


    def oscS_sendOscMessage(self, oscPre, values):
        if self.touchOscConnected:
            try:
                # print('sending Message', oscPre, values)
                self.oscClient.send_message(oscPre, values)
            except:
                print('message send fail')
                self.touchOscConnected = False


    def osrR_reaperSetAutomationMode(self, *args, sIdx=0):
        self.localRouter.reaperControlClient.oscS_setWriteForTrack(sIdx, bool(args[0]))


    def setupOscBindings(self):
        for sIdx in range(self.numSourcesInInterface):
            _oscPreSel = '/select/{}'.format(sIdx + 1).encode()
            self.oscPre_uiSourceSelect.append(_oscPreSel)
            self.oscServer.bind(_oscPreSel, partial(self.oscR_sourceSelect, sIdx=sIdx))

            _oscPreLink = '/link/{}'.format(sIdx + 1).encode()

            self.oscPre_uiSourceLink.append(_oscPreLink)
            self.oscServer.bind(_oscPreLink, partial(self.oscR_sourceLink, sIdx=sIdx))

            _oscPreWrite = '/setWrite/{}'.format(sIdx).encode()
            self.oscPre_autoWriteReaper.append(_oscPreWrite)
            self.oscServer.bind(_oscPreWrite, partial(self.osrR_reaperSetAutomationMode, sIdx=sIdx))

        # print(self.oscPre_uiSourceLink)
        for key, osc in self.oscPre_uiPos.items():
            self.oscServer.bind(osc[0], partial(self.oscR_positionUpdate, key))

        for i in range(6):
            self.oscPre_uiFollowerXy.append('/xy{}'.format(i).encode())

        for key, _oscPre in self.oscPre_setGain.items():
            self.oscServer.bind(_oscPre[0], partial(self.oscR_setGain, key=key))

        self.oscServer.bind(b'/connect/touch', self.oscR_connectionRequest)
        self.oscServer.bind(b'/pluginsend', self.oscR_pluginSendActive)
        self.oscServer.bind(b'/connect/router', self.oscR_connectToRoute)



class SeamlessPluginCommunicator(CommunicationClients):

    oscPre_positions = {}
    oscPre_gain = b'/send/gain'

    def __init__(self, *args, **kwargs):
        super(SeamlessPluginCommunicator, self).__init__(*args)
        self.clientName = 'Seamless Plugin'
        self.greetingMessage()

        # self.processInput = True

        self.setupOscBindings()

    def setupOscBindings(self):
        # for idx in range(globalConfig['number_sources']):
        for _cxyz in ['x', 'y', 'z']:
            _oscPre = '/source/pos/{}'.format(_cxyz).encode()
            self.oscPre_positions[_cxyz] = _oscPre
            self.oscServer.bind(_oscPre, partial(self.oscR_sourcePosition, key=_cxyz))
        self.oscServer.bind(self.oscPre_gain, self.oscR_sourceGain)

    def oscR_sourcePosition(self, *args, key='x'):
        if self.localRouter.sendFromPlugin:
            sIdx = args[0]-1
            if sIdx > -1 and not sIdx in self.localRouter.touchedSources:
                if soundObjectsData_local[sIdx].setPosition(key, args[1]):
                    self.localRouter.sendPositionUpdatesFromSeamlessClient(sIdx, key, args[1])


    def oscR_sourceGain(self, *args):
        if self.localRouter.sendFromPlugin:
            sIdx = args[0]-1

            if sIdx > -1 and not sIdx in self.localRouter.touchedSourceGains:
                rIdx = args[1]
                value = args[2]
                if soundObjectsData_local[sIdx].setRendererGain(rIdx, value):
                    self.localRouter.sendGainUpdatesFromSeamlessClient(sIdx, rIdx, value)

    def oscS_sendPositionToPlugin(self, sIdx, key, values):
        if key == 'xy':
            self.oscS_sendPositionToPlugin(sIdx, 'x', [values[0]])
            self.oscS_sendPositionToPlugin(sIdx, 'y', [values[1]])
        elif key == 'azim':
            _valueX = soundObjectsData_local[sIdx].getPosition('x')
            _valueY = soundObjectsData_local[sIdx].getPosition('y')
            self.oscS_sendPositionToPlugin(sIdx, 'x', [_valueX])
            self.oscS_sendPositionToPlugin(sIdx, 'y', [_valueY])
        elif key == 'elev' or key == 'dist':
            _valueX = soundObjectsData_local[sIdx].getPosition('x')
            _valueY = soundObjectsData_local[sIdx].getPosition('y')
            _valueZ = soundObjectsData_local[sIdx].getPosition('z')
            self.oscS_sendPositionToPlugin(sIdx, 'x', [_valueX])
            self.oscS_sendPositionToPlugin(sIdx, 'y', [_valueY])
            self.oscS_sendPositionToPlugin(sIdx, 'z', [_valueZ])

        else:
            try:
                self.oscClient.send_message(self.oscPre_positions[key], [sIdx+1, *values])
            except:
                pass

    def oscS_sendGainToPlugin(self, sIdx, key, value):
        _rIdx = self.localRouter.systemToRIdx[key]
        try:
            # print('gain to plugin', self.oscPre_gain, [sIdx+1, _rIdx, value])
            self.oscClient.send_message(self.oscPre_gain, [sIdx+1, _rIdx, value])
        except:
            pass


class SpatSourceViewer(CommunicationClients):

    def __init__(self, *args):

        super(SpatSourceViewer, self).__init__(*args)
        _port = self.oscClient.port
        self.oscClient = OSCClient(globalConfig['spatviewer'], _port)
        self.clientName = 'Spat Viewer'
        self.greetingMessage()

    def oscS_forwardPositionMessage(self, values, oscPre=b'/s'):
        # print('forwarding to spat', oscPre, values)
        self.oscClient.send_message(oscPre, values)

    def greetingMessage(self):
        super(SpatSourceViewer, self).greetingMessage()
        print('\tforwarding only!\n')



class ReaperOscCommunicator(CommunicationClients):

    oscPres_setWrite = []
    oscPres_setRead = []

    def __init__(self, *args):
        super(ReaperOscCommunicator, self).__init__(*args)
        self.clientName = 'Reaper Com'
        self.greetingMessage()

        self.setupOscPres()

    def greetingMessage(self):
        super(ReaperOscCommunicator, self).greetingMessage()
        print('\tonly set automation write\n')

    def oscS_setWriteForTrack(self, trackIdx, write:bool=True):
        if write:
            _oscPre = self.oscPres_setWrite[trackIdx]
        else:
            _oscPre = self.oscPres_setRead[trackIdx]
        try:
            self.oscClient.send_message(_oscPre, [1.0])
        except:
            pass

    def setupOscPres(self):
        for i in range(globalConfig['number_sources']):
            self.oscPres_setWrite.append('/track/{}/autolatch'.format(i).encode())
            self.oscPres_setRead.append('/track/{}/autotrim'.format(i).encode())