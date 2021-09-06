from rendererclass import Renderer, ViewClient
import str_keys_conventions as skc
from oscpy.server import OSCThreadServer
from functools import partial
from soundobjectclass import SoundObject
import ipaddress


# class OscHelper:
#     x = 4
#
#     def dosom(self):
#         bindToDataAndUiPort()
#
#
# halligalli = 'moses'
soundobjects: [SoundObject] = []

clientSubscriptions = {}
audiorouter: Renderer
renderengineClients: [Renderer] = []
dataClients: [Renderer] = []
uiClients: [Renderer] = []
allClients: [Renderer] = []
globalconfig = dict()
extendedOscInput = True
verbosity = 0
bPrintOSC = False
def setVerbosity(v:int):
    global verbosity, bPrintOSC
    verbosity = v
    bPrintOSC = v >= 2
    Renderer.setVerbosity(v)
    print('verbosity set to',v)
# sourcePrioriInput = { #put in her fromUi
#     True: True,
#     False: False
# }


osc_ui_server = OSCThreadServer()
# osc_listen_socket: OSCThreadServer # = osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)

osc_data_server = OSCThreadServer()
# osc_automation_socket: OSCThreadServer# = osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)
osc_setting_server = OSCThreadServer()


oscr_ip = False
def setupOscSettingsBindings():
    osc_setting_server.listen(address='0.0.0.0', port=globalconfig['inputport_settings'], default=True)

    osc_setting_server.bind('/oscrouter/debug/osccopy'.encode(), oscreceived_debugOscCopy)
    osc_setting_server.bind('/oscrouter/debug/verbose'.encode(), oscreceived_verbose)
    osc_setting_server.bind('/oscrouter/subscribe'.encode(), oscreceived_subscriptionRequest)
    osc_setting_server.bind('/oscrouter/ping'.encode(), oscreceived_ping)
    osc_setting_server.bind('/oscrouter/pong'.encode(), oscreceived_pong)
    osc_setting_server.bind('/oscrouter/dump'.encode(), oscreceived_dump)

    global oscr_ip
    if 'oscr_ip' in globalconfig.keys() and checkIp(globalconfig['oscr_ip']):
        oscr_ip = globalconfig['oscr_ip'].encode()




def oscreceived_ping(*args):

    # print(osc_setting_server.get_sender())
    # # print(osc_setting_server.getaddress())
    # ss = socket.socket()
    # print(ss.gethostname())
    print('received ping', args)
    if checkPort(args[0]):
        vals = [oscr_ip] if oscr_ip else []
        osc_setting_server.answer(b'/oscrouter/pong', port=args[0], values=vals)

    # _ip = osc_setting_server.get_sender()[1]
    # print(_ip)

def oscreceived_pong(*args):
    # print('something')
    try:
        # print(clientSubscriptions[args[0]])
        clientName = args[0]
        clientSubscriptions[clientName].receivedIsAlive()
    except:
        if verbosity>0:
            _name = ''
            if len(args) > 0:
                _name = args[0]
            print('no renderer for pong message {}'.format(_name))


def oscreceived_subscriptionRequest(*args):
#/oscrouter/subscribe myname 31441 xyz 0 5
#  args[0] nameFor Client
# args[1] port client listens to
# args[2] format client expects
# args[3] send source index as value instead of inside the osc prefix
# args[4] source position update rate
    print('subscribe request', args)
    viewClientInitValues = {}
    vCName = args[0]
    subArgs = len(args)
    if subArgs>=2:
        if checkPort(args[1]):
            viewClientInitValues['listenport'] = args[1]

            _ip = osc_setting_server.get_sender()[1]

            viewClientInitValues['ipaddress'] = _ip

            # if subArgs>2:
            #     initKeys = ['dataformat', 'indexAsValue', 'updateintervall']
            #     for i in range(2, subArgs):
            #         viewClientInitValues[initKeys[i-2]] = args[i]
            try:
                viewClientInitValues['dataformat'] = args[2].decode()
            except:
                pass
            try:
                viewClientInitValues['indexAsValue'] = args[3]
            except:
                pass
            try:
                viewClientInitValues['updateintervall'] = args[4]
            except:
                pass

        if not vCName in clientSubscriptions.keys():
            newViewClient = ViewClient(vCName, **viewClientInitValues)

            clientSubscriptions[vCName] = newViewClient
            uiClients.append(newViewClient)
            newViewClient.checkAlive(deleteClient)

    else:
        if verbosity>0:
            print('not enough arguments für view client')



def oscreceived_dump(*args):
    pass
    #TODO: dump all source data to renderer


def deleteClient(viewC, alias):
    if verbosity > 0:
        print('deleting client', viewC, alias)
    uiClients.remove(viewC)
    del clientSubscriptions[alias]

def checkPort(port) -> bool:
    if  type(port) == int and 1023 < port < 65535:
        return True
    else:
        if verbosity > 0:
            print('port', port, 'not legit')
        return False

def checkIp(ip) -> bool:
    ipalright = True
    try:
        _ip = '127.0.0.1' if ip == 'localhost' else ip
        _ = ipaddress.ip_address(_ip)
    except:
        ipalright = False
        if verbosity > 0:
            print('ip address', ip, 'not legit')

    return ipalright

def checkIpAndPort(ip, port) -> bool:
    return checkIp(ip) and checkPort(port)


def oscreceived_debugOscCopy(*args):
    print('received debug osc', args)
    ip=''
    port = 0
    if len(args) == 2:
        ip = args[0].decode()
        port = args[1]
    elif len(args) == 1:
        ipport = args[0].decode().split(':')
        if len(ipport) == 2:
            ip = ipport[0]
            port = ipport[1]
    else:
        Renderer.debugCopy = False
        return

    try:
        ip = '127.0.0.1' if ip=='localhost' else ip
        osccopy_ip = ipaddress.ip_address(ip)
        osccopy_port = int(port)
    except:
        print('unccorrect ip or port')
        return

    if 1023 < osccopy_port < 65535:
        Renderer.createDebugClient(str(osccopy_ip), osccopy_port)
        Renderer.debugCopy = True
        return

    Renderer.debugCopy = False


def oscreceived_verbose(*args):
    vvvv = -1
    try:
        vvvv = int(args[0])
    except:
        setVerbosity(0)
        # verbosity = 0
        # Renderer.setVerbosity(0)
        print('wrong verbosity argument')
        return

    if 0<= vvvv <=2:
        setVerbosity(vvvv)
        # global verbosity
        # verbosity = vvvv
        # Renderer.setVerbosity(vvvv)
    else:
        setVerbosity(0)

def setupOscBindings():
    setupOscSettingsBindings()

    osc_ui_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_ui], default=True)
    osc_data_server.listen(address='0.0.0.0', port=globalconfig[skc.inputport_data], default=True)


    for key, item in skc.posformat.items():

        for addr in [('/source/'+key), '/source/pos/'+key, '/source/position/'+key]:
            bindToDataAndUiPort(addr, partial(oscreceived_setPosition, key))

        if extendedOscInput:
            for i in range(globalconfig['number_sources']):
                idx = i + 1
                for addr in [('/source/'+str(idx)+'/pos/'+key), ('/source/'+str(idx)+'/position/'+key), ('/source/'+str(idx) + '/'+key)]:
                    bindToDataAndUiPort(addr, partial(oscreceived_setPositionForSource, key, i))


    for key in skc.SourceAttributes:

        addstring = '/source/' + key.value
        bindToDataAndUiPort(addstring, partial(oscReceived_setValueForAttribute, key))

        for i in range(globalconfig['number_sources']):
            idx = i + 1
            addstring = '/source/' + str(idx) + '/' + key.value
            bindToDataAndUiPort(addstring, partial(oscreceived_setValueForSourceForAttribute, i, key))

    # sendgain input
    # spatialGainAddr =
    # spatialGainAddr2 =
    for spatGAdd in ['/source/send/spatial', '/send/gain', '/source/send']:
        bindToDataAndUiPort(spatGAdd, partial(oscreceived_setRenderGain))

    if 'index_ambi' in globalconfig.keys():
        rendIdx = int(globalconfig['index_ambi'])
        for addr in ['/source/send/ambi', '/source/send/ambisonics', '/send/ambisonics', '/send/ambi']:
        #bindToDataAndUiPort('/source/send/ambi', partial(oscreceived_setRenderGainToRenderer, rendIdx))
            bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainToRenderer, rendIdx))
        if extendedOscInput:
            for i in range(globalconfig['number_sources']):
                idx = i + 1
                for addr in [
                    ('/source/' + str(idx) + '/ambi'),
                    ('/source/' + str(idx) + '/ambisonics'),
                    ('/source/' + str(idx) + '/send/ambi'),
                    ('/source/' + str(idx) + '/send/ambisonics'),
                ]:
                    bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainForSourceForRenderer, i, rendIdx))

    if 'index_wfs' in globalconfig.keys():
        rendIdx = int(globalconfig['index_wfs'])
        for addr in ['/source/send/wfs', '/source/send/wavefieldsynthesis', '/send/wfs', '/send/wavefieldsynthesis']:
            bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainToRenderer, int(globalconfig['index_wfs'])))
        #bindToDataAndUiPort('/source/send/wavefieldsynthesis', partial(oscreceived_setRenderGainToRenderer, int(globalconfig['index_wfs'])))
        if extendedOscInput:
            for i in range(globalconfig['number_sources']):
                idx = i + 1
                for addr in [
                    ('/source/' + str(idx) + '/wfs'),
                    ('/source/' + str(idx) + '/wavefieldsynthesis'),
                    ('/source/' + str(idx) + '/send/wfs'),
                    ('/source/' + str(idx) + '/send/wavefieldsynthesis'),
                ]:
                    bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainForSourceForRenderer, i, rendIdx))

    if 'index_reverb' in globalconfig.keys():
        rendIdx = int(globalconfig['index_reverb'])
        for addr in ['/source/send/reverb', '/source/send/rev', '/send/rev', '/send/reverb', '/source/reverb/gain']:

            bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainToRenderer, int(globalconfig['index_reverb'])))
        #bindToDataAndUiPort('/source/send/rev', partial(oscreceived_setRenderGainToRenderer, int(globalconfig['index_reverb'])))

        if extendedOscInput:
            for i in range(globalconfig['number_sources']):
                idx = i + 1
                for addr in [
                    ('/source/' + str(idx) + '/rev'),
                    ('/source/' + str(idx) + '/reverb'),
                    ('/source/' + str(idx) + '/send/rev'),
                    ('/source/' + str(idx) + '/send/reverb'),
                    ('/source/' + str(idx) + '/reverb/gain'),
                ]:
                    bindToDataAndUiPort(addr, partial(oscreceived_setRenderGainForSourceForRenderer, i, rendIdx))

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

    if verbosity > 2:
        for add in osc_ui_server.addresses:
            print(add)





def bindToDataAndUiPort(addr:str, func):
    # dontUseDataPortFlag = bool(globalconfig['data_port_timeout'] == 0)
    addrEnc = addr.encode()

    #if verbosity >= 2:
    osc_ui_server.bind(addrEnc, partial(printOSC, addr=addr, port=globalconfig[skc.inputport_ui]))
    osc_data_server.bind(addrEnc, partial(printOSC, addr=addr, port=globalconfig[skc.inputport_data]))

    osc_ui_server.bind(addrEnc, partial(func, fromUi=True))
    osc_data_server.bind(addrEnc, partial(func, fromUi=False))




def sourceLegit(id:int) -> bool:
    indexInRange = id in range(globalconfig['number_sources'])
    if verbosity > 0:
        if not indexInRange:
            if not type(id) == int:
                print('source index is no integer')
            else:
                print('source index out of range')
    return indexInRange

def renderIndexLegit(id:int) -> bool:
    indexInRange = id in range(globalconfig['numberofrenderengines'])
    if verbosity > 0:
        if not indexInRange:
            if not type(id) == int:
                print('renderengine index is no integer')
            else:
                print('renderengine index out of range')
    return indexInRange

def directSendLegit(id:int) -> bool:
    indexInRange = id in range(globalconfig['number_direct_sends'])
    if verbosity > 0:
        if not indexInRange:
            if not type(id) == int:
                print('direct send index is no integer')
            else:
                print('direct send index out of range')
    return indexInRange


def oscreceived_setPosition(coordKey, *args, fromUi=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        sIdx = int(sIdx)
        oscreceived_setPositionForSource(coordKey, sIdx, *args[1:], fromUi=fromUi)

def oscreceived_setPositionForSource(coordKey, sIdx: int, *args, fromUi=True):

    if(soundobjects[sIdx].setPosition(coordKey, *args, fromUi=fromUi)):
        # print('soundobject has set position', args)
        notifyRenderClientsForUpdate('sourcePositionChanged', sIdx, fromUi=fromUi)
        # notifyRendererForSourcePosition(sIdx, fromUi)


def oscreceived_setRenderGain(*args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        sIdx = int(sIdx)
        oscreceived_setRenderGainForSource(sIdx, *args[1:], fromUi)

def oscreceived_setRenderGainToRenderer(rIdx: int, *args, fromUi:bool=True):
    sIdx = args[0]-1
    if renderIndexLegit(rIdx) and sourceLegit(sIdx):
        rIdx = int(rIdx)
        sIdx = int(sIdx)
        oscreceived_setRenderGainForSourceForRenderer(sIdx, rIdx, *args[1:], fromUi=fromUi)

def oscreceived_setRenderGainForSource(sIdx: int, *args, fromUi: bool=True):
    rIdx = args[0]
    if renderIndexLegit(rIdx):
        rIdx = int(rIdx)
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
        sIdx = int(sIdx)
        oscreceived_setDirectSendForSource(sIdx, *args[1:], fromUi)

def oscreceived_setDirectSendForSource(sIdx: int, *args, fromUi:bool=True):
    cIdx = args[0]
    if directSendLegit(cIdx):#0 <= cIdx < globalconfig['number_direct_sends']:
        cIdx = int(cIdx)
        oscreceived_setDirectSendForSourceForChannel(sIdx, cIdx, *args[1:], fromUi)

def oscreceived_setDirectSendForSourceForChannel(sIdx:int, cIdx:int, *args, fromUi:bool=True):
    if soundobjects[sIdx].setDirectSend(cIdx, args[0], fromUi):
        notifyRenderClientsForUpdate('sourceDirectSendChanged', sIdx, cIdx, fromUi=fromUi)

#TODO: implement this thing
def notifyRendererForDirectsendGain(sIdx:int, cIfx:int, fromUi:bool=True):
    pass

def oscreceived_setAttribute(*args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        sIdx = int(sIdx)
        oscreceived_setAttributeForSource(sIdx, *args[1:], fromUi)

def oscreceived_setAttributeForSource(sIdx:int, *args, fromUi:bool=True):
    attribute = args[0]
    if attribute in skc.knownAttributes:
        oscreceived_setValueForSourceForAttribute(sIdx, attribute, *args[1:], fromUi)


def oscReceived_setValueForAttribute(attribute:skc.SourceAttributes, *args, fromUi:bool=True):
    sIdx = args[0]-1
    if sourceLegit(sIdx):
        sIdx = int(sIdx)
        oscreceived_setValueForSourceForAttribute(sIdx, attribute, *args[1:], fromUi)


def oscreceived_setValueForSourceForAttribute(sIdx:int, attribute:skc.SourceAttributes, *args, fromUi:bool=True):
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
    if bPrintOSC:
        print('incoming OSC on Port', port, addr, args)