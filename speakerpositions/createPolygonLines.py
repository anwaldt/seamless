
polygonPointString = '<point x="{}" y="{}" z="{}"/>'

polyTxtFile = open('HUFO/Hufo_WFS_polygon.txt')

polyLiney = polyTxtFile.readlines()
polyTxtFile.close()

points = []
for line in polyLiney[1:]:
    lp = line.split()
    points.append((lp[1],lp[2]))

pointListXml = open('pointList.xml', 'w')

z = 2.014

for pp in points:
    pointListXml.write(polygonPointString.format(*pp, z)+'\n')

pointListXml.close()