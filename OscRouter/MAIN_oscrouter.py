

import str_keys_conventions as skc
# import renderer_config as reconf
# import conversionsTools as ct

from soundobjectclass import SoundObject
from rendererclass import Renderer
import rendererclass as render

from functools import partial

from oscpy.server import OSCThreadServer

import argparse

# import numpy as np



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

        if type[0] in ['globalconfig', 'audiorouter']:
            configd[type[0]] = {}
            subdict = configd[type[0]]
        else:
            if not type[0] in configd.keys():
                configd[type[0]] = {}

            configd[type[0]][type[1]] = {}
            subdict = configd[type[0]][type[1]]

        for line in lines[1:]:
            pair = line.split()
            key = pair[0]
            value = pair[1]
            subdict[key] = value

            #configd[type[0]][type[1]] = subdict

    return configd


#read dictionaries with config informations
configpath = 'oscRouterConfig.txt'
configurationDict = getConfigurationFromFile(configpath)

extendedOscInput = True

globalconfig = configurationDict['globalconfig']

inputport_data = int(globalconfig['inputport_data'])       #for automation data. Input will not be mirrored to 'dataclients'
inputport_ui = int(globalconfig['inputport_ui'])         #for ui applications. Input will be send to every client
settings_port = int(globalconfig['settings_port'])

max_gain = float(globalconfig['max_gain'])
SoundObject.maxGain = max_gain

numberofrenderengines = len(configurationDict['renderengine'].keys())
numberofsources = int(globalconfig['number_sources']) #64

Renderer.numberOfSources = numberofsources  #
SoundObject.number_renderer = numberofrenderengines

higher_priority_pos_timeout = 1 #sec a source will be blocked for automation when using "higher priority" socket
SoundObject.higher_priority_pos_timeout = higher_priority_pos_timeout
#endregion

#region Data Storage

audiorouter:Renderer #TODO implement audiorouter
soundobjects: [SoundObject] = [SoundObject()] * numberofsources
renderengines: [Renderer] = []
dataclients: [Renderer] = []
viewclients: [Renderer] = []

print('setting audiorouter connection\n')
if 'audiorouter' in configurationDict.keys():
    audiorouter = render.createRendererClient(skc.renderClass.Audiorouter, kwargs=configurationDict['audiorouter'])
else:
    print('!!! NO AUDIOROUTER CONFIGURED')
print()

print('setting renderer connection\n')
if 'renderengine' in configurationDict.keys():
    for type, configdata in configurationDict['renderengine'].items():
        renderengines.append(render.createRendererClient(skc.renderClass(type), configdata))
else:
    print('no renderer clients in configfile')
print()

print('setting data_client connections\n')
if 'dataclient' in configurationDict.keys():
    for type, configdata in configurationDict['dataclient'].items():
        dataclients.append(render.createRendererClient(skc.renderClass(type), kwargs=configdata))
else:
    print('no data clients in configfile')
print()

print('setting UI-client connections\n')
if 'viewclient' in configurationDict.keys():
    for type, configdata in configurationDict['viewclient'].items():
        viewclients.append(render.createRendererClient(skc.renderClass(type), kwargs=configdata))
else:
    print('no UI-clients in configfile')
print('\n')

print('max number of sources is set to', str(numberofsources))
print('UI listenport:', inputport_ui)
print('DATA listenport (for automation):', inputport_data)
print('port for settings is (no function yet):', settings_port, '\n')
if extendedOscInput:
    print('extended osc-string listening activated')
else:
    print('only basic osc-strings will be accepted')

print('max gain is', max_gain)
# for ren in reconf.renderer_list:
#     renderengines.append(render.createRendererClient(ren))

#listener_clients: [Renderer] = [render.createRendererClient(skc.renderClass.Oscar)]

Renderer.sources = soundobjects

#endregion
# instantiate all osc related stuff

osc_server = OSCThreadServer()
osc_listen_socket = osc_server.listen(address='0.0.0.0', port=inputport_ui, default=True)

osc_automation_listen_server = OSCThreadServer()
osc_automation_socket = osc_automation_listen_server.listen(address='0.0.0.0', port=inputport_data, default=True)


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
    for rend in renderengines:
        rend.sourceNeedsUpdate(source_idx)
    for vc in viewclients:
        vc.sourceNeedsUpdate(source_idx)
    # for rend in dataclients:
    #     rend.sourceNeedsUpdate(source_idx)

def notifyDataClientsForSourceDataUpdate(source_idx:int):
    for dClient in dataclients:
        dClient.sourceNeedsUpdate(source_idx)


def oscreceived_setGainForSource(sIdx: int, *args):
    if(soundobjects[sIdx].setRendererGain(args[0], args[1])):
        audiorouter.sourceNeedsUpdate(sIdx)


def oscreceived_setGain(*args):
    sIdx = args[0]
    renderIdx = args[1]
    gain = args[2]
    if(soundobjects[sIdx-1].setRendererGain(renderIdx, gain)):
        audiorouter.sourceNeedsUpdate(sIdx)



def registerViewClient(*values):
    pass


for key, item in skc.posformat.items():
    addrstring = '/source/' + key
    addrst = addrstring.encode()
    osc_server.bind(addrst, partial(oscreceived_setPositionFromUserInterface, key))

    # position input in the format "/source/1/xyz f f f" (and every other possible format)
    if extendedOscInput:
        for i in range(numberofsources):
            idx = i + 1
            addrWithIndex = '/source/' + str(idx) + '/' + key
            addrstWidx = addrWithIndex.encode()
            osc_server.bind(addrstWidx, partial(oscreceived_setPositionFromUIwString, key, i))

    # print(addrstring)

# special for oscar could be extended for other data sources (automation data input)
oscarKeys = {skc.nx, skc.ny, skc.nz, skc.nd}
for key in oscarKeys:
    for i in range(1, numberofsources+1):
        addstring = '/source/' + str(i) + '/' + key
        addstring.encode()
        osc_automation_listen_server.bind(addstring, partial(oscreceived_setPositionFromAutomation_wSourceString, key, i))


# sendgain input
gainAddr = '/send/gain/individual'
gainAddrEnc = gainAddr.encode()
osc_server.bind(gainAddrEnc, oscreceived_setGain)
if extendedOscInput:
    for i in range(numberofsources):
        idx = i + 1
        gainAddr2 = '/source/' + str(idx) + '/rendergain'
        gainAddrEnc2 = gainAddr2.encode()
        osc_server.bind(gainAddrEnc2, partial(oscreceived_setGainForSource, i))
        gainAddr2 = '/source/' + str(idx) + '/send'
        gainAddrEnc2 = gainAddr2.encode()
        osc_server.bind(gainAddrEnc2, partial(oscreceived_setGainForSource, i))

print()
print('OSC router ready to use')
print('have fun...')

import signal
signal.pause()