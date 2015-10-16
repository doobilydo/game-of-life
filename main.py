# This Python file uses the following encoding: utf-8
'''
Implement Game of Life
'''
import time
import sys
from cell import Cell
from patterns import *

# A and B neighbor coordinates, relative to a cell.
# Keys are quarter increments of pi.
coordA = {0:+1, 0.25:+1, 0.5:0, 0.75:-1, 1:-1, 1.25:-1, 1.5:0, 1.75:+1}
coordB = {0:0, 0.25:-1, 0.5:-1, 0.75:-1, 1:0, 1.25:+1, 1.5:+1, 1.75:+1}

'''
Modify these variables for changing conditions.
'''
square = 20
rows = square
columns = square
lifeCycles = 150
sleepDuration = .1 # Time of lifecycle

# initial index of matrix
initB = 0
initA = 0
matrix = [[Cell() for x in range(rows)] for x in range(columns)]


'''
Entry point.
'''
def main():
    init()
    lifeCycle(lifeCycles)

'''
Initialize Cells and neighbors.
'''
def init():
    print('Initialize...%d x %d\n' % (rows, columns))

    iterateMatrix(consolidatedInit)

'''
Run a life cycle.

cycles - Number of times to run
'''
def lifeCycle(cycles):
    for cycle in range(cycles + 1):
        time.sleep(sleepDuration) # sleep
        sys.stderr.write("\x1b[2J\x1b[H") # clear screen

        # print condition information
        print('%d x %d, Cycles: %d, Speed: %d.2' % (rows, columns, lifeCycles, sleepDuration))
        print('\nCycle %d\n' %(cycle))

        b = initB
        output = ''
        for row in matrix:
            a = initA
            for cell in row:

                # Output state in a grid
                if cell.state == 1:
                    # '\033[1m' = bold
                    # '\033[94m' = blue
                    # '\033[0m' = back to normal
                    output = output + '\033[1m' + '\033[94m' + '%d ' % cell.state + '\033[0m'
                    # output = output + '%d ' % cell.state
                else:
                    # '\033[91m' = red
                    output = output + '\033[91m' + '%d ' % cell.state + '\033[0m'
                    # output = output + '%d ' % cell.state
                cell.check()
                # cell.grow()
                a = a + 1

            output = output + '\n'
            b = b + 1

        print(output)
        iterateMatrix(changeGeneration)
'''
Iterate over the matrix of cells.
'''
def iterateMatrix(function):
    b = initB
    for row in matrix:

        a = initA
        for cell in row:

            function(cell, a, b)

            a = a + 1

        b = b + 1

'''
Initialize naming, neighbors, and states in one iteration.
'''
def consolidatedInit(cell, a, b):
    cell.name = 'Cell'
    cell.coord = '(%d,%d)' % (b, a)

    meetTheNeighbors(a, b, matrix, 0, cell)

    pattern = getPattern()
    pattern(b, a, cell)

'''
Name and number the cells.
'''
# def initCells(cell, a, b):
#     cell.name = 'Cell'
#     cell.coord = '(%d,%d)' % (b, a)

'''
Have each cell find and connect with its neighbors,
'''
# def initNeighbors(cell, a, b):
#     meetTheNeighbors(a, b, matrix, 0, cell)

'''
Have a cell check its neighbors and update its status accordingly.
'''
# def cellCheck(cell, a, b):
#     cell.check()

'''
Advance each cell to the next generation.
'''
def changeGeneration(cell, a, b):
    cell.grow()

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
        # output = 'θ(%.2fπ) Bₙ(%d) Aₙ(%d)' % (theta, B, A)

        if B >= initB or A >= initA: # Anything negative should not be counted
            N = matrix[B][A] # Set neighbor
            currentCell.connect(N) # Connect the neighbor

    except IndexError: # In case the neighbor doesn't exist 'out of index'
        pass # Do nothing
        # Preventing the nonexistant neighbor from being counted

    if theta < 1.75:
        return meetTheNeighbors(a, b, matrix, theta + .25, currentCell)

    return

# Run the program
main()
