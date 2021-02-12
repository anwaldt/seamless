import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
import numpy as np

polyFile = open('HUFO/Hufo_WFS_polygon.txt', 'r')
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
ax.set_xlim((-10, 10))
ax.set_ylim((-7, 7))

# for pp in npPoints:
#     plt.scatter(pp[0], pp[1])
# x = np.linspace(0, 2*np.pi, 10)
# y = np.sin(x)
# ax.scatter(xs,ys)


plt.show()


# plt.plot(npPoints)