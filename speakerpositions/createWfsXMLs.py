# import xml.etree.ElementTree as EL


# from lxml import etree
#
# s = """<?xml version="1.0"?>
# <speakerarray SYSTEM="twonder_speakerarray.dtd"/>"""
#
# tree = etree.fromstring(s)
# header = etree.SubElement(tree,'header',{'adminlang': 'EN'})
# body = etree.SubElement(tree,'body')
#
# print(etree.tostring(tree, encoding="UTF-8",
#                      xml_declaration=True,
#                      pretty_print=False,
#                      doctype='<!DOCTYPE speakerarray SYSTEM "twonder_speakerarray.dtd>'))

# import argparse
# parser = argparse.ArgumentParser


panelfile = 'HUFO/Hufo_WFS_Panels.txt'

header = '<?xml version="1.0"?>'
doctype = '<!DOCTYPE speakerarray SYSTEM "twonder_speakerarray.dtd">'
speakerarray_open = '<speakerarray>'
speakerarray_close = '</speakerarray>'

segment_open = '<segment'
segment_close = '/>'

panel_dict = {
    'id': "",
    'startx': "",
    'starty': "",
    'startz': "",
    'endx': "",
    'endy': "",
    'endz': "",
    'normalx': "",
    'normaly': "",
    'normalz:': "",
}
panelseg_string = '<segment id="{}" numspeak="8" winwidth="0" ' \
               'startx="{}" ' \
               'starty="{}" ' \
               'startz="{}" ' \
               'endx="{}" ' \
               'endy="{}" ' \
               'endz="{}" ' \
               'normalx="{}" ' \
               'normaly="{}" ' \
               'normalz="{}" />'

def createSegmentString(fromDic: dict) -> str:
    to_str = panelseg_string.format( fromDic['id'],
        fromDic['startx'], fromDic['starty'], fromDic['startz'], fromDic['endx'], fromDic['endy'], fromDic['endz'], fromDic['normalx'], fromDic['normaly'], fromDic['normalz']
    )
    return to_str

config_txt = open(panelfile, 'r')
config_lines = config_txt.readlines()
config_txt.close()

xml_segemnt_lines = []

for idx, line in enumerate(config_lines[1:]):
    le = line.split()
    panel_dict['id'] = str(idx+1)
    panel_dict['startx'] = str(le[0])
    panel_dict['starty'] = str(le[1])
    panel_dict['startz'] = str(le[4])
    panel_dict['endx'] = str(le[2])
    panel_dict['endy'] = str(le[3])
    panel_dict['endz'] = str(le[4])
    panel_dict['normalx'] = str(le[5])
    panel_dict['normaly'] = str(le[6])
    panel_dict['normalz'] = str(0)

    xml_segemnt_lines.append(createSegmentString(panel_dict))

print(len(xml_segemnt_lines), 'Panels')

from pathlib import Path
def createTwonderXmlFile(file_ids, seg_ids, nSegmentsPerFile,  folder): # len(file_ids) * nSegmentsPerFile = len(seg_ids) !
    if len(file_ids) * nSegmentsPerFile == len(seg_ids):
        print('creating...')
        segC = 0
        Path(folder).mkdir(parents=True, exist_ok=True)
        for i, j in enumerate(file_ids):
            fname = 'twonder_speakerarray{}.xml'.format(j)
            path = folder + '/' + fname

            fxml = open(path, 'w')
            fxml.write(header+'\n\n'+doctype+'\n\n'+speakerarray_open+'\n')
            for _ in range(nSegmentsPerFile):
                fxml.write('\t'+xml_segemnt_lines[seg_ids[segC]]+'\n')
                segC = segC + 1

            fxml.write(speakerarray_close)

            print('\t', path)
        print('created', len(file_ids), 'files')
    else:
        print('ERROR in function call for folder ', folder, '\n wrong file_ids/seg_ids config \n', len(file_ids), len(seg_ids), nSegmentsPerFile)
        return


createTwonderXmlFile(list(range(1,9)), list(range(0, 16)), 2, 'PanelXMLS/node1')
createTwonderXmlFile(list(range(1,9)), list(range(16, 32)), 2, 'PanelXMLS/node2')



# for i in range(4):
#     fname = 'twonder_speakerarray{}.xml'.format(i+1)
#     path = '/Users/psch/Desktop/PanelXMLS/node1/{}'.format(fname)
#     file = open(path, 'w')
#     file.write()
#
# for i in range(8):
#     fname = 'twonder_speakerarray{}.xml'.format(i + 1)
