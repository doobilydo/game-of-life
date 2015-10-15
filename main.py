# This Python file uses the following encoding: utf-8
import numpy
import time
import sys

'''
Implement Game of Life
'''
from cell import Cell

# A and B neighbor coordinates, relative to a cell.
# Keys are quarter increments of pi.
coordA = {0:+1, 0.25:+1, 0.5:0, 0.75:-1, 1:-1, 1.25:-1, 1.5:0, 1.75:+1}
coordB = {0:0, 0.25:-1, 0.5:-1, 0.75:-1, 1:0, 1.25:+1, 1.5:+1, 1.75:+1}


# for i in range(5):
#     time.sleep(.5)
#     # sys.stdout.write("\r%d" % (i+1))
#     print('\r%d %d %d' % (i, (i+1), (i+2))), # the comma prevents a new line
#     sys.stdout.flush()
#
# sys.stdout.write('\n')

# range
rows = 3
columns = 3
initB = 0
initA = 0
matrix = [[Cell() for x in range(rows)] for x in range(columns)]


'''
'''
def main():
    print('%d x %d' % (rows, columns))
    init()
    lifeCycle(1)


'''
Initialize Cells and neighbors.
'''
def init():
    print('Initialize...\n')

    # First, name each Cell (for convenience).
    iterateMatrix(initCells)

    # Second, meet each neighbor.
    iterateMatrix(initNeighbors)

    iterateMatrix(sanityCheck)


def iterateMatrix(function):
    b = initB
    for row in matrix:

        a = initA
        for cell in row:

            function(cell, a, b)

            a = a + 1

        b = b + 1


def initCells(cell, a, b):
    cell.name = 'Cell'
    cell.coord = '(%d,%d)' % (b, a)

    # if b == 2 and a == 2:
    #     cell.state = 1
    # else:
    #     cell.state = 1

    # meetTheNeighbors(a, b, matrix, 0, cell)


def initNeighbors(cell, a, b):
    # print('row = %d (Columns: %d)\n' % (b, len(row)))

    # print('Column=%d, Search for neighbors...' % a) # Print cell initial

    # cell.printStatus()
    meetTheNeighbors(a, b, matrix, 0, cell)
    # cell.printStatus()


def sanityCheck(cell, a, b):
    cell.printStatus()


'''
Run a life cycle.

cycles - Number of times to run
'''
def lifeCycle(cycles):

    for cycle in range(cycles):
        print('\nCycle %d\n' %(cycles))

        iterateMatrix(cellCheck)
        iterateMatrix(sanityCheck)


def cellCheck(cell, a, b):
    cell.check()
    # cell.printStatus()


'''
Check immediate surroundings for existing neighbors.
2-dimensional perspective, 3x3 grid.

a - A position
b - B position
matrixB - List of data
θ - Angle pointing to next neighbor (measured in radians, quarter increments of pi)
'''
def meetTheNeighbors(a, b, matrix, theta, currentCell):
    output = ''
    try:
        A = a + coordA[theta] # Cell's 'a' coord plus 'A' distance of neighbor
        B = b + coordB[theta] # Cell's 'b' coord plus 'B' distance of neighbor

        # Add output for the log
        output = 'θ(%.2fπ) Bₙ(%d) Aₙ(%d)' % (theta, B, A)

        if B < initB or A < initA: # Negative numbers counted as 'out of index'
            output = output + ' Doesn\'t exist'
        else:
            N = matrix[B][A] # Set neighbor
            output = output + (' Neighbor\'s name: %s' % N.fullName)
            currentCell.connect(N) # Connect the neighbor

    except IndexError: # In case the neighbor doesn't exist 'out of index'
        # Add output for the log
        output = output + ' Doesn\'t exist'

    # print(output + '\n')

    if theta < 1.75:
        return meetTheNeighbors(a, b, matrix, theta + .25, currentCell)

    return


# Run the program
main()
