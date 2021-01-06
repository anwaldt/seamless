

import str_keys_conventions as skc
# import renderer_config as reconf
# import conversionsTools as ct

from soundobjectclass import SoundObject
from rendererclass import Renderer
import rendererclass as render

from functools import partial

from oscpy.server import OSCThreadServer

import numpy as np



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

globalconfig = configurationDict['globalconfig']

inputport_data = globalconfig['inputport_data']       #for automation data. Input will not be mirrored to 'dataclients'
inputport_ui = globalconfig['inputport_ui']         #for ui applications. Input will be send to every client
settings_port = globalconfig['settings_port']


numberofrenderengines = len(configurationDict['renderengine'].keys())#len(reconf.renderer_list)
numberofsources = globalconfig['number_sources']#64
Renderer.numberOfSources = numberofsources

higher_priority_pos_timeout = 1 #sec a source will be blocked for automation when using "higher priority" socket
SoundObject.higher_priority_pos_timeout = higher_priority_pos_timeout
#endregion

#region Data Storage

audiorouter:Renderer #TODO implement audiorouter
soundobjects = [SoundObject()] * numberofsources
renderengines: [Renderer] = []
dataclients: [Renderer] = []
viewclients: [Renderer] = []

if 'audiorouter' in configurationDict.keys():
    audiorouter = render.createRendererClient(skc.renderClass.Audiorouter, kwargs=configurationDict['audiorouter'])

if 'renderengine' in configurationDict.keys():
    for type, configdata in configurationDict['renderengine'].items():

        renderengines.append(render.createRendererClient(skc.renderClass(type), kwargs=configdata))

if 'dataclient' in configurationDict.keys():
    for type, configdata in configurationDict['dataclient'].items():

        dataclients.append(render.createRendererClient(skc.renderClass(type), kwargs=configdata))

if 'viewclient' in configurationDict.keys():
    for type, configdata in configurationDict['viewclient'].items():

        viewclients.append(render.createRendererClient(skc.renderClass(type), kwargs=configdata))


# for ren in reconf.renderer_list:
#     renderengines.append(render.createRendererClient(ren))

listener_clients: [Renderer] = [render.createRendererClient(skc.renderClass.Oscar)]

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

def received_setPositionFromUserInterface(coord_key, *values):
    # print(coord_key, pos_key_list, values)
    # update renderer getPosition
    s_idx = int(values[0] -1)
    if(soundobjects[s_idx].setPositionFromUserInterface(coord_key, values[1:])):
        notifyRendererForSourcePosition(s_idx)

def received_setPositionFromAutomation_wSourceString(coord_key, source, *values):
    s_idx = source -1
    if(soundobjects[s_idx].setPositionFromAutomation(coord_key, values)):
        notifyRendererForSourcePosition(s_idx)

def notifyRendererForSourcePosition(source_idx):
    for rend in renderengines:
        rend.sourceNeedsPositionUpdate(source_idx)
    for rend in listener_clients:
        rend.sourceNeedsPositionUpdate(source_idx)

def registerViewClient(*values):
    pass


for key, item in skc.posformat.items():
    addrstring = '/source/pos/' + key
    addrst = addrstring.encode()
    osc_server.bind(addrst, partial(received_setPositionFromUserInterface, key))
    # print(addrstring)


oscarKeys = {skc.nx, skc.ny, skc.nz, skc.nd}
for key in oscarKeys:
    for i in range(1, numberofsources+1):
        addstring = '/source/' + str(i) + '/' + key
        addstring.encode()
        osc_automation_listen_server.bind(addstring, partial(received_setPositionFromAutomation_wSourceString, key , i))


# osc_server.bind_meta_routes()


import signal
signal.pause()