
'''
Define which pattern to utilize.
'''
def getPattern():
    return block4

'''
Initialize state pattern 1.
'''
def pattern1(a,b, cell):
    if b == 2 and a == 2:
        cell.state = 1
    else:
        cell.state = 0

'''
Initialize state pattern 2.
'''
def pattern2(a,b, cell):
    if b == a:
        cell.state = 1
    else:
        cell.state = 0

'''
First four cells are alive.
'''
def block4(a,b, cell):
    if (b == 0 and a == 0) or (b == 0 and a == 1) or (b == 1 and a == 0) or (b == 1 and a == 1):
        cell.state = 1
    else:
        cell.state = 0
