#!/usr/bin/env python3

import str_keys_conventions as skc
import conversionsTools as ct

from soundobjectclass import SoundObject
from rendererclass import Renderer
import rendererclass# as rendererclass

from functools import partial

from oscpy.server import OSCThreadServer

import argparse

parser = argparse.ArgumentParser(description='OSC Message Processor and Router')
parser.add_argument('--config', default='oscRouterConfig.txt', help='path to configfile', type=str)
parser.add_argument('--oscdebug', default='', help='ip and port for debug messages, e.g. "130.149.23.46 55112"', type=str)
args = parser.parse_args()

configpath = args.config
# configpath = 'oscRouterConfig.txt'

s_oscDebug = args.oscdebug


if s_oscDebug:
    debugIp = s_oscDebug.split()[0]
    debugPort = int(s_oscDebug.split(':')[1])
    Renderer.createDebugClient(debugIp, debugPort)
    Renderer.debugCopy = True



#region pre init attributes

def getConfigurationFromFile(path: str) -> dict:
    configd = dict()

    configfile = open(path, 'r')
    config = configfile.read()
    configfile.close()
    blocks = config.split('***')

    for block in blocks:

        lines = block.split('\n')

        while '' in lines:
            lines.remove('')
        if not lines:
            break

        type = lines[0].split()

        if type[0] in ['globalconfig']:
            configd[type[0]] = {}
            subdict = configd[type[0]]
        elif type[0] in ['audiorouter']:
            if not 'audiorouter' in configd.keys():
                configd[type[0]] = []
            subdict = {}
            configd['audiorouter'].append(subdict)

        else:
            if not type[0] in configd.keys():
                configd[type[0]] = {}

            configd[type[0]][type[1]] = {}
            subdict = configd[type[0]][type[1]]

        for line in lines[1:]:
            pair = line.split()
            key = pair[0]
            value = ct.convertedValue(pair[1])
            subdict[key] = value

            #configd[type[0]][type[1]] = subdict

    return configd




#read dictionaries with config informations

configurationDict = getConfigurationFromFile(configpath)

extendedOscInput = True

globalconfig = configurationDict['globalconfig']
SoundObject.globalConfig = globalconfig
Renderer.globalConfig = globalconfig


# inputport_data = int(globalconfig['inputport_data'])       #for automation data. Input will not be mirrored to 'dataclients'
# inputport_ui = int(globalconfig['inputport_ui'])         #for ui applications. Input will be send to every client
# settings_port = int(globalconfig['settings_port'])

# max_gain = float(globalconfig['max_gain'])
# SoundObject.maxGain = max_gain

numberofrenderengines = len(configurationDict['renderengine'].keys())
numberofsources = int(globalconfig['number_sources']) #64

Renderer.numberOfSources = numberofsources  #
SoundObject.number_renderer = numberofrenderengines

# higher_priority_pos_timeout = 1 #sec a source will be blocked for automation when using "higher priority" socket
# SoundObject.data_port_timeout = higher_priority_pos_timeout
#endregion

#region Data initialisation


soundobjects: [SoundObject] = []
for i in range(numberofsources):
    soundobjects.append(SoundObject(objectID=1))

audiorouter: Renderer = None
renderengineClients: [Renderer] = []
dataClients: [Renderer] = []
uiClients: [Renderer] = []
allClients: [Renderer] = []


print('setting audiorouter connection\n')
if 'audiorouter' in configurationDict.keys():


    for dic in configurationDict['audiorouter']:
        if not audiorouter:
            audiorouter = rendererclass.createRendererClient(skc.renderClass.Audiorouter, kwargs=dic)
        else:
            audiorouter.addDestination(dic['ipaddress'], dic['listenport'])

else:
    print('!!! NO AUDIOROUTER CONFIGURED')
print()

print('setting renderer connection\n')
if 'renderengine' in configurationDict.keys():
    for type, configdata in configurationDict['renderengine'].items():
        renderengineClients.append(rendererclass.createRendererClient(skc.renderClass(type), configdata))

else:
    print('no renderer clients in configfile')
print()

print('setting data_client connections\n')
if 'dataclient' in configurationDict.keys():
    for type, configdata in configurationDict['dataclient'].items():
        dataClients.append(rendererclass.createRendererClient(skc.renderClass(type), kwargs=configdata))
else:
    print('no data clients in configfile')
print()

print('setting UI-client connections\n')
if 'viewclient' in configurationDict.keys():
    for type, configdata in configurationDict['viewclient'].items():
        uiClients.append(rendererclass.createRendererClient(skc.renderClass(type), kwargs=configdata))
else:
    print('no UI-clients in configfile')
print('\n')

print('max number of sources is set to', str(numberofsources))
print('UI listenport:', globalconfig[skc.inputport_ui])
print('DATA listenport (for automation):', globalconfig[skc.inputport_data])
print('port for settings is (no function yet):', globalconfig[skc.settings_port], '\n')
if extendedOscInput:
    print('extended osc-string listening activated')
else:
    print('only basic osc-strings will be accepted')

print('max gain is', globalconfig[skc.max_gain])

for ren in [*renderengineClients, *dataClients, *uiClients]:
    allClients.append(ren)


Renderer.sources = soundobjects

#endregion

#region osc
# instantiate all osc related stuff

osc_ui_server = OSCThreadServer()
osc_listen_socket = osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)

osc_data_server = OSCThreadServer()
osc_automation_socket = osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)


def callbackk(sttt, *values):
    pass
    # exit()


def oscreceived_setPositionFromUserInterface(coord_key, *values):

    s_idx = int(values[0] - 1)
    if(soundobjects[s_idx].setPositionFromUserInterface(coord_key, values[1:])):
        notifyRendererForSourcePosition(s_idx)
        notifyDataClientsForSourceDataUpdate(s_idx)


def oscreceived_setPositionFromUIwString(coord_key, s_idx, *values):

    if (soundobjects[s_idx].setPositionFromUserInterface(coord_key, values)):
        notifyRendererForSourcePosition(s_idx)
        notifyDataClientsForSourceDataUpdate(s_idx)


def oscreceived_setPositionFromAutomation_wSourceString(coord_key, source, *values):
    s_idx = source -1
    if(soundobjects[s_idx].setPositionFromAutomation(coord_key, values)):
        notifyRendererForSourcePosition(s_idx)


def notifyRendererForSourcePosition(source_idx:int):
    for rend in renderengineClients:
        rend.sourceNeedsUpdate(source_idx)
    for vc in uiClients:
        vc.sourceNeedsUpdate(source_idx)
    # for rend in dataclients:
    #     rend.sourceNeedsUpdate(source_idx)

def notifyDataClientsForSourceDataUpdate(source_idx:int):
    for dClient in dataClients:
        dClient.sourceNeedsUpdate(source_idx)


def oscreceived_setGainForSource(sIdx: int, *args):
    if(soundobjects[sIdx].setRendererGain(args[0], args[1])):
        audiorouter.sourceNeedsUpdate(sIdx)


def oscreceived_setGain(*args):
    if args[0] > 0:
        sIdx = args[0]-1
        renderIdx = args[1]
        gain = args[2]
        if(soundobjects[sIdx].setRendererGain(renderIdx, gain)):
            audiorouter.sourceNeedsUpdate(sIdx)

def oscreceived_sourceAttribute(attribute: skc.SourceAttributes, *args: list):

    sidx = args.pop(0)
    oscreceived_sourceAttribute_wString(sidx, attribute, args)


def oscreceived_sourceAttribute_wString(sidx: int, attribute: skc.SourceAttributes, *args):
    sobject = soundobjects[sidx]
    if(sobject.setSourceAttribute(attribute, args[0])):
        for ren in allClients:
            ren.sourceAttributeChanged(sidx, attribute)


def registerViewClient(*values):
    pass


for key, item in skc.posformat.items():
    addrstring = '/source/' + key
    addrst = addrstring.encode()
    osc_ui_server.bind(addrst, partial(oscreceived_setPositionFromUserInterface, key))

    # position input in the format "/source/1/xyz f f f" (and every other possible format)
    if extendedOscInput:
        for i in range(numberofsources):
            idx = i + 1
            addrWithIndex = '/source/' + str(idx) + '/' + key
            addrstWidx = addrWithIndex.encode()
            osc_ui_server.bind(addrstWidx, partial(oscreceived_setPositionFromUIwString, key, i))

    # print(addrstring)

# special for oscar could be extended for other data sources (automation data input)
oscarKeys = {skc.nx, skc.ny, skc.nz, skc.nd}
for key in oscarKeys:
    for i in range(1, numberofsources+1):
        addstring = '/source/' + str(i) + '/' + key
        addstring.encode()
        osc_data_server.bind(addstring, partial(oscreceived_setPositionFromAutomation_wSourceString, key, i))

for key in skc.SourceAttributes:

    addstring = '/source/' + key.value
    addstring.encode()
    osc_data_server.bind(addstring, oscreceived_sourceAttribute)
    osc_ui_server.bind(addstring, oscreceived_sourceAttribute)

    for i in range(1, numberofsources+1):
        addstring = '/source/' + str(i) + '/' + key.value
        addstring.encode()
        osc_data_server.bind(addstring, partial(oscreceived_sourceAttribute_wString, i - 0))
        osc_ui_server.bind(addstring, partial(oscreceived_sourceAttribute_wString, i - 0))


# sendgain input
gainAddr = '/send/gain/individual'
gainAddrEnc = gainAddr.encode()
osc_ui_server.bind(gainAddrEnc, oscreceived_setGain)
if extendedOscInput:
    for i in range(numberofsources):
        idx = i + 1
        gainAddr2 = '/source/' + str(idx) + '/rendergain'
        gainAddrEnc2 = gainAddr2.encode()
        osc_ui_server.bind(gainAddrEnc2, partial(oscreceived_setGainForSource, i))
        gainAddr2 = '/source/' + str(idx) + '/send'
        gainAddrEnc2 = gainAddr2.encode()
        osc_ui_server.bind(gainAddrEnc2, partial(oscreceived_setGainForSource, i))

#endregion

print()
print('OSC router ready to use')
print('have fun...')

import signal
signal.pause()