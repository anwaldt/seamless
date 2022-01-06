"""
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
-> panel answers NOT to ping, may take a few seconds
"""


import os, platform
import threading
#import platform
import time
from oscpy import server, client
# from subprocess import check_output
import subprocess as sp

keepOnRunning = True

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
        # response = os.system(pingStr + self.address)
        # response = check_output([pingStr, self.address])
        subchild = sp.Popen([*pingStr.split(), self.address],  stdout=sp.PIPE)
        daat = subchild.communicate()[0]
        response = subchild.returncode
        # print(self.name, response)
        if response == 0:
            self.reachable = True
        else:
            self.reachable = False


panelList = list()

file = open("panelList.txt")
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
        oscClient.send_message(b'/panel/ok', [panel.name.encode()])
    else:
        oscClient.send_message(b'/panel/error', [panel.name.encode()])

    return panel.reachable

time.sleep(3)

oscServer = server.OSCThreadServer()
oscServer.listen('0.0.0.0', 41234, default=True)
oscClient = client.OSCClient(address='172.25.18.204', port=41231)

def oscR_receivedCheckRequest(*args):
    remoteAddress = oscServer.get_sender()[1]
    # print(remoteAddress)
    oscServer.answer(b'/ping/request', [], port=41231)
    global oscClient
    oscClient = client.OSCClient(remoteAddress, 41231)
    # oscClient.send_message(b'/ping/request', [])
    # checkPanelReachable()
    # pingAllPanels()
    sendPanelStatus()

def sendPanelStatus():
    allPanelsOk = True
    paarThreads = list()
    for panel in panelList:
        paarThreads.append(threading.Thread(target=pingPanel, args=(panel,)))
    for threads in paarThreads:
        threads.start()
        # if pingPanel(panel):
        #     allPanelsOk = False
        #     oscClient.send_message(b'/panel/error', [panel.name.encode()])

    # if allPanelsOk:
    #     oscClient.send_message(b'/panel/ok', [])


def checkPanelReachable():
    pingAllPanels()
    for panel in panelList:
        if panel.reachable:
            _statusString = " reachable, OK!!"
        else:
            _statusString = " ERRORERROR!!!!!!!"

        print("name: " + panel.name, " addr:" +panel.address + _statusString)

oscServer.bind(b'/check/panels', oscR_receivedCheckRequest)


#pingAllPanels()
#oscR_receivedCheckRequest()
# signal.pause()
# checkPanelReachable()
while keepOnRunning:
    time.sleep(10)
# with server.OSCThreadServer
