
'''
Define which pattern to utilize.
'''
def getPattern():
    return pattern4

'''
Coordinate 2,2 is alive.
Death
'''
def pattern1(b, a, cell):
    if b == 2 and a == 2:
        cell.state = 1
    else:
        cell.state = 0

'''
Any equal coordinates are alive.
Death
'''
def pattern2(b, a, cell):
    if b == a:
        cell.state = 1
    else:
        cell.state = 0

'''
First four cells are alive.
Stale
'''
def block4(b, a, cell):
    if (b == 0 and a == 0) or (b == 0 and a == 1) or (b == 1 and a == 0) or (b == 1 and a == 1):
        cell.state = 1
    else:
        cell.state = 0

'''
Scattered.
Stale at about cycle 22.
'''
def pattern3(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'0,1':1, '1,0':1, '1,1':1, '2,0':1, '0,2':1, '4,1':1, '4,2':1, '5,1':1, '1,4':1, '1,5':1, '1,2':1, '4,4':1, '3,4':1, '4,3':1}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
Scattered.
Left a stale group at about cycle 38, but came back and ate it at about cycle 60. Used 20x20 matrix. A series of stale shapes at about cycle 100.
'''
def pattern4(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'0,1':1, '1,0':1, '1,1':1, '2,0':1, '4,1':1, '4,2':1, '5,1':1, '1,4':1, '1,5':1, '1,2':1, '4,4':1, '3,4':1, '4,3':1}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0
