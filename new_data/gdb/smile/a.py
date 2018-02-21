import os

z = []

for i in os.listdir('.'):
    z.append(i)
    # print z

for p in z:
    x = os.system('babel a.smi "%s" -ofpt' % (p))
    print p,x
