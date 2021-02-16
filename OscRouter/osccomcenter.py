from rendererclass import Renderer
import str_keys_conventions as skc
from oscpy.server import OSCThreadServer
from functools import partial
from soundobjectclass import SoundObject



# class OscHelper:
#     x = 4
#
#     def dosom(self):
#         bindToDataAndUiPort()
#
#
# halligalli = 'moses'
soundobjects: [SoundObject] = []

audiorouter: Renderer = None
renderengineClients: [Renderer] = []
dataClients: [Renderer] = []
uiClients: [Renderer] = []
allClients: [Renderer] = []
globalconfig = dict()
extendedOscInput = True
# sourcePrioriInput = { #put in her fromUi
#     True: True,
#     False: False
# }


osc_ui_server = OSCThreadServer()
osc_listen_socket: OSCThreadServer # = osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)

osc_data_server = OSCThreadServer()
osc_automation_socket: OSCThreadServer# = osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)


def setupOscBindings():
    osc_ui_socket = osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)
    osc_data_socket = osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)


    for key, item in skc.posformat.items():
        # addrstring = '/source/' + key
        # addrst = addrstring.encode()
        for addr in [('/source/'+key), '/source/pos/'+key]:
            bindToDataAndUiPort(addr.encode(), partial(oscreceived_setPosition, key))
        # osc_ui_server.bind(addrst, partial(oscreceived_setPositionFromUserInterface, key))
        # bindToDataAndUiPort(addrst, partial(oscreceived_setPosition, key))

        # position input in the format "/source/1/xyz f f f" (and every other possible format)
        if extendedOscInput:
            for i in range(globalconfig['number_sources']):
                idx = i + 1
                for addr in [('/source/'+str(idx)+'/pos/'+key), ('/source/'+str(idx) + '/'+key)]:
                    bindToDataAndUiPort(addr.encode(), partial(oscreceived_setPositionForSource, key, i))
                # addrWithIndex = '/source/' + str(idx) + '/' + key
                # addrstWidx = addrWithIndex.encode()
                # osc_ui_server.bind(addrstWidx, partial(oscreceived_setPositionFromUIwString, key, i))
                # osc_data_server.bind(addrstWidx, partial(oscreceived_setPositionFromAutomation_wSourceString, key, i))

    for key in skc.SourceAttributes:

        addstring = '/source/' + key.value
        addstring.encode()
        osc_data_server.bind(addstring, oscreceived_sourceAttribute)
        osc_ui_server.bind(addstring, oscreceived_sourceAttribute)

        for i in range(globalconfig['number_sources']):
            idx = i + 1
            addstring = '/source/' + str(idx) + '/' + key.value
            addstring.encode()
            osc_data_server.bind(addstring, partial(oscreceived_sourceAttribute_wString, idx))
            osc_ui_server.bind(addstring, partial(oscreceived_sourceAttribute_wString, idx))

    # sendgain input
    spatialGainAddr = b'/source/send/spatial'
    bindToDataAndUiPort(spatialGainAddr, partial(oscreceived_setRenderGain))
    directSendAddr = b'/source/send/direct'
    bindToDataAndUiPort(directSendAddr, partial(oscreceived_setDirectSend))
    # osc_ui_server.bind(gainAddrEnc, partial(oscreceived_setRenderGain, fromUi=True))
    # osc_data_server.bind(gainAddrEnc, partial(oscreceived_setRenderGain, fromUi=False))
    if extendedOscInput:
        for i in range(globalconfig['number_sources']):
            idx = i + 1
            for addr in [('/source/' + str(idx) + '/rendergain'),
                         ('/source/' + str(idx) + '/send/spatial'),
                         ('/source/' + str(idx) + '/spatial'),
                         ('/source/' + str(idx) + '/sendspatial')]:

                bindToDataAndUiPort(addr.encode(), partial(oscreceived_setRenderGainForSource, idx))

                for j in range(len(renderengineClients)):
                    addr2 = addr + '/' + str(j)
                    bindToDataAndUiPort(addr2.encode(), partial(oscreceived_setRenderGainForSourceForRenderer, idx, j))

            for addr in [('/source/' + str(idx) + '/direct'),
                         ('/source/' + str(idx) + '/directsend'),
                         ('/source/' + str(idx) + '/senddirect'),
                         ('/source/' + str(idx) + '/send/direct')]:
                bindToDataAndUiPort(addr.encode(), partial(oscreceived_setDirectSendForSource, idx))

                for j in range(globalconfig['number_direct_sends']):
                    addr2 = addr + '/' + str(j)
                    bindToDataAndUiPort(addr2.encode(), partial(oscreceived_setDirectSendForSourceForChannel, idx, j))




def bindToDataAndUiPort(addr, func):
    # dontUseDataPortFlag = bool(globalconfig['data_port_timeout'] == 0)
    osc_ui_server.bind(addr, partial(func, fromUi=True))
    osc_data_server.bind(addr, partial(func, fromUi=False))

def sourceLegit(id:int) -> bool:
    return 0<=id<globalconfig['number_sources']


def oscreceived_setPosition(coordKey, *args, fromUi=True):
    sIdx = args.pop(0)-1
    if sourceLegit(sIdx):
        oscreceived_setPositionForSource(coordKey, sIdx, args, fromUi)

def oscreceived_setPositionForSource(coordKey, sIdx: int, *args, fromUi=True):

    if(soundobjects[sIdx].setPosition(coordKey, args, fromUi)):
        notifyRendererForSourcePosition(sIdx, fromUi)


def notifyRendererForSourcePosition(source_idx:int, fromUi:bool=True):
    for rend in [*renderengineClients, *uiClients]:
        rend.sourceChanged(source_idx)
    if not fromUi:
        for rend in dataClients:
            rend.sourceChanged(source_idx)


def oscreceived_setRenderGain(*args, fromUi:bool=True):
    sIdx = args.pop(0)-1
    if sourceLegit(sIdx):
        oscreceived_setRenderGainForSource(sIdx, args, fromUi)

def oscreceived_setRenderGainForSource(sIdx: int, *args, fromUi: bool=True):
    rIdx = args.pop(0)
    if 0 <= rIdx < len(renderengineClients):
        oscreceived_setRenderGainForSourceForRenderer(sIdx, rIdx, args, fromUi=fromUi)


def oscreceived_setRenderGainForSourceForRenderer(sIdx:int, rIdx: int, *args, fromUi:bool=True):
    if soundobjects[sIdx].setRendererGain(rIdx, args[0], fromUi):
        pass

def notifyRendererForRendergain(sIdx: int, rIdx:int, fromUi: bool = True):
    for rend in [*renderengineClients, *uiClients]:
        rend.sourceChanged(sIdx)
    if not fromUi:
        for rend in dataClients:
            rend.sourceChanged(sIdx)

def oscreceived_setDirectSend(*args, fromUi:bool=True):
    sIdx = args.pop(0)
    if sourceLegit(sIdx):
        oscreceived_setDirectSendForSource(sIdx, args, fromUi)

def oscreceived_setDirectSendForSource(sIdx: int, *args, fromUi:bool=True):
    cIdx = args.pop(0)
    if 0 <= cIdx < globalconfig['number_direct_sends']:
        oscreceived_setDirectSendForSourceForChannel(sIdx, cIdx, args, fromUi)

def oscreceived_setDirectSendForSourceForChannel(sIdx:int, cIdx:int, *args, fromUi:bool=True):
    if soundobjects[sIdx].setDirectSend(cIdx, args[0], fromUi):
        pass

def notifyRendererForDirectsendGain(sIdx:int, cIfx:int, fromUi:bool=True):
    pass

def oscreceived_setAttribute(*args, fromUi:bool=True):
    sIdx = args.pop(0)
    if sourceLegit(sIdx):
        oscreceived_setAttributeForSource(sIdx, args, fromUi)

def oscreceived_setAttributeForSource(sIdx:int, *args, fromUi:bool=True):
    attribute = args.pop(0)
    if attribute in skc.knownAttributes:
        oscreceived_setAttributeForSourceForAttribute(sIdx, attribute, fromUi)


def oscreceived_setAttributeForSourceForAttribute(sIdx:int, attribute:skc.SourceAttributes, fromUi:bool=True):
    if soundobjects[sIdx].setAttribute(sIdx):
        pass

def notifyRenderForAttributeChange(sIdx:int, attribute:skc.SourceAttributes):
    pass

def oscreceived_sourceAttribute(attribute: skc.SourceAttributes, *args: list):

    sidx = args.pop(0)
    if sidx > 0 and sidx < 65:
        oscreceived_sourceAttribute_wString(sidx, attribute, args)

def oscreceived_sourceAttribute_wString(sidx: int, attribute: skc.SourceAttributes, *args):
    sobject = soundobjects[sidx]
    if(sobject.setAttribute(attribute, args[0])):
        for ren in allClients:
            ren.sourceAttributeChanged(sidx, attribute)
