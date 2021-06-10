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

audiorouter: Renderer
renderengineClients: [Renderer] = []
dataClients: [Renderer] = []
uiClients: [Renderer] = []
allClients: [Renderer] = []
globalconfig = dict()
extendedOscInput = True
verbosity = 0
# sourcePrioriInput = { #put in her fromUi
#     True: True,
#     False: False
# }


osc_ui_server = OSCThreadServer()
# osc_listen_socket: OSCThreadServer # = osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)

osc_data_server = OSCThreadServer()
# osc_automation_socket: OSCThreadServer# = osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)


def setupOscBindings():

    osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)
    osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)


    for key, item in skc.posformat.items():

        for addr in [('/source/'+key), '/source/pos/'+key]:
            bindToDataAndUiPort(addr, partial(oscreceived_setPosition, key))

        if extendedOscInput:
            for i in range(globalconfig['number_sources']):
                idx = i + 1
                for addr in [('/source/'+str(idx)+'/pos/'+key), ('/source/'+str(idx) + '/'+key)]:
                    bindToDataAndUiPort(addr, partial(oscreceived_setPositionForSource, key, i))


    for key in skc.SourceAttributes:

        addstring = '/source/' + key.value
        bindToDataAndUiPort(addstring, partial(oscReceived_setAttributeForAttribute, key))

        for i in range(globalconfig['number_sources']):
            idx = i + 1
            addstring = '/source/' + str(idx) + '/' + key.value
            bindToDataAndUiPort(addstring, partial(oscreceived_setAttributeForSourceForAttribute, i, key))

    # sendgain input
    spatialGainAddr = '/source/send/spatial'
    spatialGainAddr2 =  '/send/gain'
    for spatGAdd in [spatialGainAddr2, spatialGainAddr]:
        bindToDataAndUiPort(spatGAdd, partial(oscreceived_setRenderGain))
    directSendAddr = '/source/send/direct'
    bindToDataAndUiPort(directSendAddr, partial(oscreceived_setDirectSend))
    if extendedOscInput:
        for i in range(globalconfig['number_sources']):
            idx = i + 1
            for addr in [('/source/' + str(idx) + '/rendergain'),
                         ('/source/' + str(idx) + '/send/spatial'),
                         ('/source/' + str(idx) + '/spatial'),
                         ('/source/' + str(idx) + '/sendspatial')]:

                bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainForSource, i))

                for j in range(len(renderengineClients)):
                    addr2 = addr + '/' + str(j)
                    bindToDataAndUiPort(addr2, partial(oscreceived_setRenderGainForSourceForRenderer, i, j))
                    # print('spatial sends oscar addresses', addr2)

            for addr in [('/source/' + str(idx) + '/direct'),
                         ('/source/' + str(idx) + '/directsend'),
                         ('/source/' + str(idx) + '/senddirect'),
                         ('/source/' + str(idx) + '/send/direct')]:
                bindToDataAndUiPort(addr, partial(oscreceived_setDirectSendForSource, idx))

                for j in range(globalconfig['number_direct_sends']):
                    addr2 = addr + '/' + str(j)
                    bindToDataAndUiPort(addr2, partial(oscreceived_setDirectSendForSourceForChannel, idx, j))




def bindToDataAndUiPort(addr:str, func):
    # dontUseDataPortFlag = bool(globalconfig['data_port_timeout'] == 0)
    addrEnc = addr.encode()

    if verbosity >= 2:
        osc_ui_server.bind(addrEnc, partial(printOSC, addr=addr, port=globalconfig[skc.inputport_ui]))
        osc_data_server.bind(addrEnc, partial(printOSC, addr=addr, port=globalconfig[skc.inputport_data]))

    osc_ui_server.bind(addrEnc, partial(func, fromUi=True))
    osc_data_server.bind(addrEnc, partial(func, fromUi=False))




def sourceLegit(id:int) -> bool:
    return 0<=id<globalconfig['number_sources']

def renderIndexLegit(id:int) -> bool:
    return 0<=id<globalconfig['numberofrenderengines']

def directSendLegit(id:int) -> bool:
    return 0<=id<globalconfig['number_direct_sends']


def oscreceived_setPosition(coordKey, *args, fromUi=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        oscreceived_setPositionForSource(coordKey, sIdx, *args[1:], fromUi=fromUi)

def oscreceived_setPositionForSource(coordKey, sIdx: int, *args, fromUi=True):


    if(soundobjects[sIdx].setPosition(coordKey, *args, fromUi=fromUi)):
        #print('soundobject has set position')
        notifyRenderClientsForUpdate('sourcePositionChanged', sIdx, fromUi=fromUi)
        # notifyRendererForSourcePosition(sIdx, fromUi)


def oscreceived_setRenderGain(*args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        oscreceived_setRenderGainForSource(sIdx, *args[1:], fromUi)

def oscreceived_setRenderGainForSource(sIdx: int, *args, fromUi: bool=True):
    rIdx = args[0]
    if renderIndexLegit(rIdx):
        oscreceived_setRenderGainForSourceForRenderer(sIdx, rIdx, *args[1:], fromUi=fromUi)

def oscreceived_setRenderGainForSourceForRenderer(sIdx:int, rIdx: int, *args, fromUi:bool=True):

    if soundobjects[sIdx].setRendererGain(rIdx, args[0], fromUi):
        notifyRenderClientsForUpdate('sourceRenderGainChanged', sIdx, rIdx, fromUi=fromUi)
        # notifyRendererForRendergain(sIdx, rIdx, fromUi)

# def notifyRendererForRendergain(sIdx: int, rIdx:int, fromUi: bool = True):
#
#     for rend in [*renderengineClients, *uiClients]:
#         rend.sourceRenderGainChanged(sIdx, rIdx)
#     if fromUi:
#         for rend in dataClients:
#             rend.sourceChanged(sIdx)

def oscreceived_setDirectSend(*args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        oscreceived_setDirectSendForSource(sIdx, *args[1:], fromUi)

def oscreceived_setDirectSendForSource(sIdx: int, *args, fromUi:bool=True):
    cIdx = args[0]
    if 0 <= cIdx < globalconfig['number_direct_sends']:
        oscreceived_setDirectSendForSourceForChannel(sIdx, cIdx, *args[1:], fromUi)

def oscreceived_setDirectSendForSourceForChannel(sIdx:int, cIdx:int, *args, fromUi:bool=True):
    if soundobjects[sIdx].setDirectSend(cIdx, args[0], fromUi):
        notifyRenderClientsForUpdate('sourceDirectSendChanged', sIdx, cIdx, fromUi=fromUi)

def notifyRendererForDirectsendGain(sIdx:int, cIfx:int, fromUi:bool=True):
    pass

def oscreceived_setAttribute(*args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        oscreceived_setAttributeForSource(sIdx, *args[1:], fromUi)

def oscreceived_setAttributeForSource(sIdx:int, *args, fromUi:bool=True):
    attribute = args[0]
    if attribute in skc.knownAttributes:
        oscreceived_setAttributeForSourceForAttribute(sIdx, attribute, fromUi)


def oscReceived_setAttributeForAttribute(attribute:skc.SourceAttributes, *args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        oscreceived_setAttributeForSourceForAttribute(sIdx, attribute, *args[1:], fromUi)


def oscreceived_setAttributeForSourceForAttribute(sIdx:int, attribute:skc.SourceAttributes, *args, fromUi:bool=True):
    if soundobjects[sIdx].setAttribute(attribute, args[0], fromUi):
        notifyRenderClientsForUpdate('sourceAttributeChanged', sIdx, attribute, fromUi=fromUi)
        # notifyRenderForAttributeChange(sIdx, attribute, fromUi)

# def notifyRenderForAttributeChange(sIdx:int, attribute:skc.SourceAttributes, fromUi:bool=True):
#     p

def notifyRenderClientsForUpdate(updateFunction: str, *args, fromUi:bool=True):
    for rend in [*renderengineClients, *uiClients, audiorouter]:
        #print("notifying renderer", rend)
        updatFunc = getattr(rend, updateFunction)
        updatFunc(*args)

        # updateFunction(rend, args[0])
    if fromUi:
        for rend in dataClients:
            updatFunc = getattr(rend, updateFunction)
            updatFunc(*args)



######
def oscreceived_sourceAttribute(attribute: skc.SourceAttributes, *args):

    sidx = int(args[0])-1
    if sidx >= 0 and sidx < 64:
        oscreceived_sourceAttribute_wString(sidx, attribute, args[1:])

def oscreceived_sourceAttribute_wString(sidx: int, attribute: skc.SourceAttributes, *args):
    sobject = soundobjects[sidx]
    if(sobject.setAttribute(attribute, args[0])):
        for ren in allClients:
            ren.sourceAttributeChanged(sidx, attribute)


def printOSC(*args, addr:str='', port:int=0):
    print('incoming OSC on Port', port, addr, args)