#!/usr/bin/env python3

import str_keys_conventions as skc
import conversionsTools as ct

from soundobjectclass import SoundObject
from rendererclass import Renderer
import rendererclass# as rendererclass
import osccomcenter

from functools import partial

from oscpy.server import OSCThreadServer

import argparse

parser = argparse.ArgumentParser(description='OSC Message Processor and Router')
parser.add_argument('--config', default='oscRouterConfig.txt', help='path to configfile', type=str)
parser.add_argument('--oscdebug', default='', help='ip and port for debug messages, e.g. "130.149.23.46:55112"', type=str)
parser.add_argument('-v', '--verbose', action='count', default=0, help=' increase verbosity level.')
args = parser.parse_args()

osccomcenter.verbosity = args.verbose
rendererclass.verbosity = args.verbose

configpath = args.config
# configpath = 'oscRouterConfig.txt'

s_oscDebug = args.oscdebug

if s_oscDebug:
    oscDebugParams = s_oscDebug.split(':')
    debugIp = oscDebugParams[0]
    debugPort = int(oscDebugParams[1])
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
osccomcenter.extendedOscInput = extendedOscInput

globalconfig = configurationDict['globalconfig']
# SoundObject.globalConfig = globalconfig
SoundObject.readGlobalConfig(globalconfig)
Renderer.globalConfig = globalconfig
osccomcenter.globalconfig = globalconfig

globalconfig['numberofrenderengines'] = configurationDict['globalconfig']['number_renderunits']#len(configurationDict['renderengine'].keys())

# inputport_data = int(globalconfig['inputport_data'])       #for automation data. Input will not be mirrored to 'dataclients'
# inputport_ui = int(globalconfig['inputport_ui'])         #for ui applications. Input will be send to every client
# settings_port = int(globalconfig['settings_port'])

# max_gain = float(globalconfig['max_gain'])
# SoundObject.maxGain = max_gain

numberofrenderengines = len(configurationDict['renderengine'].keys())
numberofsources = int(globalconfig['number_sources']) #64

Renderer.numberOfSources = numberofsources  #
SoundObject.number_renderer = int(globalconfig['numberofrenderengines'])

# SoundObject.preferUi = bool(globalconfig['data_port_timeout'] == 0)

# higher_priority_pos_timeout = 1 #sec a source will be blocked for automation when using "higher priority" socket
# SoundObject.data_port_timeout = higher_priority_pos_timeout
#endregion

#region Data initialisation


soundobjects: [SoundObject] = []
for i in range(numberofsources):
    soundobjects.append(SoundObject(objectID=i+1))
Renderer.sources = soundobjects

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
print('number of rendering units is', str(globalconfig['numberofrenderengines']))
if 'index_ambi' in globalconfig.keys():
    print('ambisonics index:', globalconfig['index_ambi'])
if 'index_wfs' in globalconfig.keys():
    print('wfs index:', globalconfig['index_wfs'])
if 'index_reverb' in globalconfig.keys():
    print('reverb index:', globalconfig['index_reverb'])

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

#endregion


if Renderer.debugCopy:
    print('Osc-Messages will be copied to', debugIp, ':', debugPort)
else:
    print('No Debug client configured')

print('Verbosity Level is', args.verbose)
if args.verbose == 1:
    print('outgoing osc will be printed in console')
elif args.verbose > 1:
    print('incoming and outgoing osc will be printed in console')

# print('creating OSC bindings...')
###
osccomcenter.soundobjects = soundobjects
osccomcenter.audiorouter = audiorouter
osccomcenter.renderengineClients = renderengineClients
osccomcenter.dataClients = dataClients
osccomcenter.uiClients = uiClients
osccomcenter.allClients = allClients

osccomcenter.setupOscBindings()
###

print()
print('OSC router ready to use')
print('have fun...')

import signal
signal.pause()