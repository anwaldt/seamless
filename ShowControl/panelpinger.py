"""

OSC interface:
init request:
send to port: 41234
osc:  /check/panels

return messages:
on port 41231
osc: /check/panels
-> confirmation that testing started

osc: /panel/ok panelName
-> panel answers to ping
osc: /panel/error panelName
-> panel answers NOT to ping-message, may take a few seconds
"""


import os, platform, sys
import threading
#import platform
import time

# from subprocess import check_output
import subprocess as sp
import argparse

keepOnRunning = True

parser = argparse.ArgumentParser(description='Tool to send a ping to a list of devices')
parser.add_argument('-l', '--devicelist', default='panelList.txt', type=str, help='Path to devicelist file')
parser.add_argument('-r', '--remotedevice', default='172.25.18.204', type=str, help='address for remotedevice, in theory the scripts answers to the ip of requeste-sender')
parser.add_argument('-n', '--noosc', default=False, action='store_true', help='do not open osc server, just check and quit')
args = parser.parse_args()


useOsc = True
if args.noosc:
    useOsc = False
    print("no osc-server will be opened")
else:
    try:
        from oscpy import server, client
    except ImportError:
        currentdir = os.path.dirname(os.path.realpath(__file__))
        parentdir = os.path.dirname(currentdir)
        sys.path.append(currentdir)
        try:
            from oscpy import server, client
        except ImportError:
            print("no osc-package found")
            useOsc = False

if useOsc:
    print("osc-server reachable on port 41234: /check/panels, answer comes on port 41231")


if platform.system() == "Windows":
    pingStr = "ping -n 1 "
else:
    pingStr = "ping -c 1 "

class WfsPanel:
    def __init__(self, name, address, reachable=False):
        self.name = name
        self.address = address
        self.reachable = reachable

    def testPing(self):

        subchild = sp.Popen([*pingStr.split(), self.address],  stdout=sp.PIPE)
        daat = subchild.communicate()[0]
        response = subchild.returncode
        if response == 0:
            self.reachable = True
        else:
            self.reachable = False


panelList = list()

file = open(args.devicelist)
rawPanelsString = file.read().split("\n")
file.close()

for line in rawPanelsString:
    if line:
        _pName, _pAddress = line.split()
        panelList.append(WfsPanel(_pName, _pAddress))
        print(_pName, _pAddress)

print("NumberPanels: ", len(panelList))

def pingAllPanels():
    for panel in panelList:
        panel.testPing()

def pingPanel(panel) -> bool:
    panel.testPing()
    if panel.reachable:
        if useOsc:
            oscClient.send_message(b'/panel/ok', [panel.name.encode(), panel.address.encode()])
    else:
        if useOsc:
            oscClient.send_message(b'/panel/error', [panel.name.encode()])

    return panel.reachable

time.sleep(3)

def oscR_receivedCheckRequest(*args):
    print("getting ping request")
    try:
        remoteAddress = oscServer.get_sender()[1]
        print("from ", remoteAddress)
        oscServer.answer(b'/ping/request', [], port=41231)
        global oscClient
        oscClient = client.OSCClient(remoteAddress, 41231)
    except:
        pass

    sendPanelStatus()

def sendPanelStatus():
    allPanelsOk = True
    paarThreads = list()
    for panel in panelList:
        paarThreads.append(threading.Thread(target=pingPanel, args=(panel,)))
    for threads in paarThreads:
        threads.start()
        time.sleep(0.05)


def checkPanelReachable():
    # pingAllPanels()
    sendPanelStatus()
    for panel in panelList:
        # panel.testPing()
        if panel.reachable:
            _statusString = " reachable, OK!!"
        else:
            _statusString = " ERRORERROR!!!!!!!"

        print("name: " + panel.name, "addr:" +panel.address + " status: " + _statusString)

if useOsc:
    oscServer = server.OSCThreadServer()
    oscServer.listen('0.0.0.0', 41234, default=True)
    oscClient = client.OSCClient(address=args.remotedevice, port=41231)
    oscServer.bind(b'/check/panels', oscR_receivedCheckRequest)


checkPanelReachable()

if useOsc:
    while keepOnRunning:
        time.sleep(10)
