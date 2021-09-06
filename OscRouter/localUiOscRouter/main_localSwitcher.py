


#imports from oscrouter
# import str_keys_conventions as skc
import conversionsTools as ct
from CommunicationClients import LocalOscrouter
# pluginOscReceiver = OSCThreadServer(timeout=0.005)

# osc_toPlugin = OSCClient('127.0.0.1', 9001)
# osc_toRender = OSCClient('127.0.0.1', 9007)
# osc_toReaper = OSCClient('127.0.0.1', 9005)

configpath = 'oscRouterConfig.txt'

remoteOscRouter_ip = '127.0.0.1'
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



import signal

if __name__ == '__main__':
    localRouter = LocalOscrouter(globalConfig)
    # print(globalConfig['number_sources'])

    signal.pause()