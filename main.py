# This Python file uses the following encoding: utf-8
import numpy

'''
Implement Game of Life
'''
from cell import Cell

# A and B neighbor coordinates, relative to a cell.
# Keys are quarter increments of pi.
coordA = {0:+1, 0.25:+1, 0.5:0, 0.75:-1, 1:-1, 1.25:-1, 1.5:0, 1.75:+1}
coordB = {0:0, 0.25:-1, 0.5:-1, 0.75:-1, 1:0, 1.25:+1, 1.5:+1, 1.75:+1}


'''
Initial program
'''
def main():
    # initialCell = Cell();
    # initialCell.name = 'Zero'
    # matrixA = [initialCell]
    # matrixB = [matrixA]
    matrix = [[Cell() for x in range(3)] for x in range(3)]

    # First, name each Cell.
    b = 0
    for row in matrix:

        a = 0
        for cell in row:
            cell.name = 'Cell'
            cell.coord = '(%d,%d)' % (b, a)

            a = a + 1

        b = b + 1


    # Second, meet each neighbor.
    b = 0
    for row in matrix:
        print('row = %d (Columns: %d)\n' % (b, len(row)))

        a = 0
        for cell in row:
            print('Column=%d, Search for neighbors...' % a) # Print cell initial

            # cell.name = 'Cell'
            # cell.coord = '(%d,%d)' % (b, a)
            cell.printStatus()
            meetTheNeighbors(a, b, matrix, 0, cell)
            cell.printStatus()

            a = a + 1

        b = b + 1


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

        if B < 0 or A < 0:
            output = output + ' Doesn\'t exist'
        else:
            N = matrix[B][A] # Set neighbor
            output = output + (' Neighbor\'s name: %s' % N.fullName)
            currentCell.connect(N) # Connect the neighbor

    except IndexError: # In case the neighbor doesn't exist
        # Add output for the log
        output = output + ' Doesn\'t exist'

    print(output + '\n')

    if theta < 1.75:
        return meetTheNeighbors(a, b, matrix, theta + .25, currentCell)

    return


# Run the program
main()
