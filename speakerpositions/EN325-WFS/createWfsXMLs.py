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
    to_str = '<segment id="{}" numspeak="8" winwidth="0" ' \
                      'startx="{}" ' \
                      'starty="{}" ' \
                      'startz="{}" ' \
                      'endx="{}" ' \
                      'endy="{}" ' \
                      'endz="{}" ' \
                      'normalx="{}" ' \
                      'normaly="{}" ' \
                      'normalz="{}" />'.format( fromDic['id'],
        fromDic['startx'], fromDic['starty'], fromDic['startz'], fromDic['endx'], fromDic['endy'], fromDic['endz'], fromDic['normalx'], fromDic['normaly'], fromDic['normalz']
    )
    return to_str

config_txt = open('/Users/psch/Desktop/EN325_WFS_Panels.txt', 'r')
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

print(len(xml_segemnt_lines))


def createTwonderXmlFile(file_ids, seg_ids, nSegmentsPerFile,  folder):
    segC = 0
    for i, j in enumerate(file_ids):
        fname = 'twonder_speakerarray{}.xml'.format(j)
        path = folder + '/' + fname

        fxml = open(path, 'w')
        fxml.write(header+'\n\n'+doctype+'\n\n'+speakerarray_open+'\n')
        for _ in range(nSegmentsPerFile):
            fxml.write(xml_segemnt_lines[seg_ids[segC]]+'\n')
            segC = segC + 1

        fxml.write(speakerarray_close)


createTwonderXmlFile(list(range(1,5)), list(range(0, 8)), 2, '/Users/psch/Desktop/PanelXMLS/node1')
createTwonderXmlFile(list(range(1,9)), list(range(8, 24)), 2, '/Users/psch/Desktop/PanelXMLS/node2')


# for i in range(4):
#     fname = 'twonder_speakerarray{}.xml'.format(i+1)
#     path = '/Users/psch/Desktop/PanelXMLS/node1/{}'.format(fname)
#     file = open(path, 'w')
#     file.write()
#
# for i in range(8):
#     fname = 'twonder_speakerarray{}.xml'.format(i + 1)
