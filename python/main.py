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
square = 50 # Use this for 'rows' and 'columns' if you want a square
rows = square
columns = square
lifeCycles = 10000
sleepDuration = .05 # Time of lifecycle
holdCount = 0
hold = 'true'

# colors
livingCell = '\033[96m'
deadCell = '\033[90m'
'''
89 = white
90 = gray
91 = red
92 = lime green
93 = yellow
94 = purple
95 = magenta
96 = cyan
97 = white
'\033[1m' = bold
'\033[0m' = back to normal
'''

# initial index of matrix
initB = 0
initA = 0
matrix = [[Cell() for x in range(columns)] for x in range(rows)]


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

    iterateMatrix(initCells)

'''
Run a life cycle.

cycles - Number of times to run
'''
def lifeCycle(cycles):
    for cycle in range(cycles + 1):
        time.sleep(sleepDuration) # sleep
        sys.stderr.write("\x1b[2J\x1b[H") # clear screen

        # print condition information
        patternUsed = getPattern().__name__
        print('%d x %d, Pattern: ' % (rows, columns) + patternUsed),
        print(', Cycles: %d, Length of cycle: %.2f seconds, ' % (lifeCycles, sleepDuration)),
        print('Cycle %d\n' %(cycle))

        b = initB
        output = ''
        for row in matrix:
            a = initA
            for cell in row:

                # Output state in a grid
                if cell.state == 1:
                    output = output + '\033[1m' +  livingCell + '%d ' % cell.state + '\033[0m'
                else:
                    output = output + deadCell + '%d ' % cell.state + '\033[0m'
                # cell.check()
                a = a + 1

            output = output + '\n'
            b = b + 1

        print(output)

        if cycle < holdCount and hold == 'true':
            pass
        else:
            b = initB
            for row in matrix:

                a = initA
                for cell in row:

                    cell.check()

                    a = a + 1

                b = b + 1
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
def initCells(cell, a, b):
    cell.name = 'Cell'
    cell.coord = '(%d,%d)' % (b, a)

    meetTheNeighbors(a, b, matrix, 0, cell)

    pattern = getPattern()
    pattern(b, a, cell)

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
matrix - List of data
theta - Angle pointing to next neighbor (measured in radians, quarter increments of pi)
currentCell - Cell in iteration
'''
def meetTheNeighbors(a, b, matrix, theta, currentCell):
    output = ''
    try:
        A = a + coordA[theta] # Cell's 'a' coord plus 'A' distance of neighbor
        B = b + coordB[theta] # Cell's 'b' coord plus 'B' distance of neighbor

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
