
'''
Noteable patterns:
pattern4
pattern4b
'''

'''
Define which pattern to utilize.
'''
def getPattern():
    return pattern4b

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

'''
Pattern4, B and A increased by 5.
Ends at 50 cycles. 4 stale entities.
'''
def pattern5(b, a, cell):
    coord = '%d,%d' % (b,a)

    # Increase all by 5
    dict = {'5,6':1, '6,5':1, '6,6':1, '7,5':1, '9,6':1, '9,7':1, '10,6':1, '6,9':1, '6,10':1, '6,7':1, '9,9':1, '8,9':1, '9,8':1}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
Pattern4, First 5 are the same. Others, B and A increased by 5.
Ends at 50 cycles. 2 stale entities.
'''
def pattern6(b, a, cell):
    coord = '%d,%d' % (b,a)

    # Increase all by 5
    dict = {'0,1':1, '1,0':1, '1,1':1, '2,0':1, '4,1':1, '9,7':1, '10,6':1, '6,9':1, '6,10':1, '6,7':1, '9,9':1, '8,9':1, '9,8':1}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
Ugh, lots of set up for a more annoying setup process.
Died at 50 cycles.
'''
def pattern7(b, a, cell):
    coord = '%d,%d' % (b,a)

    # Increase all by 5
    dict = {
    '0,0':0, '0,1':1, '0,2':1, '0,3':0, '0,4':0, '0,5':0, '0,6':1, '0,7':0, '0,8':0, '0,9':0, '0,10':0,
    '1,0':1, '1,1':1, '1,2':0, '1,3':0, '1,4':0, '1,5':1, '1,6':0, '1,7':0, '1,8':0, '1,9':0, '1,10':0,
    '2,0':1, '2,1':0, '2,2':0, '2,3':0, '2,4':1, '2,5':1, '2,6':0, '2,7':0, '2,8':0, '2,9':0, '2,10':0,
    '3,0':0, '3,1':0, '3,2':0, '3,3':1, '3,4':1, '3,5':1, '3,6':0, '3,7':0, '3,8':0, '3,9':0, '3,10':0,
    '4,0':0, '4,1':0, '4,2':1, '4,3':1, '4,4':1, '4,5':0, '4,6':0, '4,7':0, '4,8':0, '4,9':0, '4,10':0,
    '5,0':0, '5,1':1, '5,2':1, '5,3':1, '5,4':0, '5,5':0, '5,6':0, '5,7':0, '5,8':0, '5,9':0, '5,10':0,
    '6,0':1, '6,1':0, '6,2':0, '6,3':0, '6,4':0, '6,5':0, '6,6':0, '6,7':0, '6,8':0, '6,9':0, '6,10':0,
    '7,0':0, '7,1':0, '7,2':0, '7,3':0, '7,4':0, '7,5':0, '7,6':0, '7,7':0, '7,8':0, '7,9':0, '7,10':0,
    '8,0':0, '8,1':0, '8,2':0, '8,3':0, '8,4':0, '8,5':0, '8,6':0, '8,7':0, '8,8':0, '8,9':0, '8,10':0,
    '9,0':0, '9,1':0, '9,2':0, '9,3':0, '9,4':0, '9,5':0, '9,6':0, '9,7':0, '9,8':0, '9,9':0, '9,10':0,
    '10,0':0, '10,1':0, '10,2':0, '10,3':0, '10,4':0, '10,5':0, '10,6':0, '10,7':0, '10,8':0, '10,9':0, '10,10':0
    }

    if(coord in dict):
        cell.state = dict[coord]
    else:
        cell.state = 0

'''
Pattern4, increased by 20 on each axis. Things brings it more to the center.
Cool beans. 48x100. About 600 cycles.
Cake taken.
'''
def pattern4b(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'20,21':1, '21,20':1, '21,21':1, '22,20':1, '24,21':1, '24,22':1,
    '25,21':1, '21,24':1, '21,25':1, '21,22':1, '24,24':1, '23,24':1, '24,23':1}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
A symetrical version of pattern4. Went nowhere.
'''
def pattern8(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'20,41', '21,40', '20,42', '20,40', '22,40', '22,44', '24,41', '24,42', '25,41', '21,44', '21,45', '24,44', '23,44', '24,43'}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
Pattern4 upper left triangle inverted along the (1,1) axis.
Stale at about 120 cycles.
'''
def pattern9(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'20,41', '21,40', '19,41', '20,40', '21,39', '24,41', '24,42', '25,41', '21,44', '21,45', '24,44', '23,44', '24,43'}

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
Pattern4 upper left triangle inverted along the (1,1) axis. All symetrical.
Died at about 10 cycles.
(Keep as template)
'''
def pattern10(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'20,41', '21,40', '19,41', '20,40', '21,39',
    '22,44', '24,41', '24,42', '25,41', '21,44', '21,45', '24,44', '23,44', '24,43' }

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0

'''
Pattern4 upper left triangle inverted along the (1,1) axis.
Symmetry is bad.
'''
def pattern11(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'20,41', '21,40', '19,41', '20,40', '21,39',
    '21,44', '21,45', '22,44', '23,44', '24,41', '24,42', '24,43', '24,44', '25,41', }

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0


'''
Happy Birthday!!
'''
def pattern12(b, a, cell):
    coord = '%d,%d' % (b,a)

    dict = {'15,10', '16,10', '17,10', '16,11', '15,12', '16,12', '17,12', # H
    '15,14', '16,14', '17,14', '15,15', '16,15', '15,16', '16,16', '17,16', # A
    '15,18', '16,18', '17,18', '15,19', '16,19', '15,20', '16,20', # P
    '15,22', '16,22', '17,22', '15,23', '16,23', '15,24', '16,24', # P
    '15,26', '16,27', '17,27', '15,28', # Y
    '19,4', '18,4', '19,5', '20,4', '21,4', '22,4',  '20,5', '20,6',  '21,5',
    '22,5', '22,6', '23,4', '24,4', '23,5', # B
    '20,8', '20,9', '21,9', '22,9', '20,10', '22,8', '22,9', '22,10', # I
    '20,12', '21,12', '22,12', '23,12', '20,13', '21,13', '20,14', '21,14',
    '22,13', '23,14', # R
    '20,16', '20,17', '20,18', '21,17', '22,17', # T
    '20,20', '21,20', '22,20', '21,21', '20,22', '21,22', '22,22', # H
    '20,24', '21,24', '22,24', '20,25', '22,25', '21,26', # D
    '20,28', '21,28', '22,28', '20,29', '21,29', '20,30', '21,30', '22,30', # A
    '20,32', '21,33', '22,33', '20,34', # Y
    '19,36', '20,36', '21,36', '22,36', '24,36', #!
    '19,38', '20,38', '21,38', '22,38', '24,38' #!
    }

    if(coord in dict):
        cell.state = 1
    else:
        cell.state = 0
