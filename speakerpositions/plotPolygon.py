import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
import numpy as np

polyFile = open('EN325-WFS/EN325_WFS_Polygon.txt', 'r')
lines = polyFile.readlines()
polyFile.close()
pypoints = []

for line in lines[1:]:
    pp = line.split()
    # print(line)
    if len(pp) > 1:
        pypoints.append((pp[1],pp[2]))

npPoints = np.array(pypoints)

poly = Polygon(npPoints)
# poly.set_hatch('+')
# poly.set_linestyle('-.')
poly.set_linewidth(2)
# poly.set_capstyle('round')
poly.fill = False
poly.set_zorder(1)
# poly.set_animated(True)




fig, ax = plt.subplots()
ax.add_patch(poly)

# ax.add_patch(a)
# for pp in pypoints:
#     print(pp)
#     ax.plot(pp[0], pp[1], 'o')

xs = []
ys = []

# print(points_sorted)
# for pp in points_sorted:
#     xs.append(pp[0])
#     ys.append(pp[1])

print(xs)
print(ys)
# plt.plot(xs,ys)
ax.set_xlim((-5, 5))
ax.set_ylim((-3, 3))
ax.axis('equal')

plt.xlabel('x / m')
plt.ylabel('y / m')

 

plt.savefig('en325-wfs.pdf')  