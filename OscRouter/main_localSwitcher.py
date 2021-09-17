



import conversionsTools as ct
from CommunicationClients import LocalOscrouter

import argparse

parser = argparse.ArgumentParser(description='Local OSC-Message Router for Production in Hufo System')
parser.add_argument('-r', '--remote', default='127.0.0.1', type=str, help='Ip address of remote osc router')
parser.add_argument('-s', '--spatviewer', default='127.0.0.1', type=str, help='ip address of spat viewer')
parser.add_argument('-a', '--autosubscribe', action='store_true', help='automatically connect to remote osc-router')
parser.add_argument('-p', '--pluginaddress', default='127.0.0.1', type=str, help='automatically connect to remote osc-router')
args = parser.parse_args()

configpath = 'oscRouterConfig.txt'

remoteOscRouter_ip = args.remote
remoteOscRouter_portData = 4455
remoteOscROuter_portSettings = 4999


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


globalConfig = getConfigurationFromFile(configpath)['globalconfig']
globalConfig['spatviewer'] = args.spatviewer



import signal

if __name__ == '__main__':
    localRouter = LocalOscrouter(globalConfig, remoteIp=remoteOscRouter_ip, autosubscribe=bool(args.autosubscribe), pluginAddress=args.pluginaddress)
    # print(globalConfig['number_sources'])

    signal.pause()