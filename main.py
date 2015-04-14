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
    matrixA = [Cell()]
    matrixB = [matrixA]

    b = 0
    for B in matrixB:
        print('B = %d' % b)

        a = 0
        for A in B:
            print('Ai=%d, Search for neighbors...' % a) # Print A initial
##            A = Cell()
            print(A)
            checkForNeighbors(a, b, matrixB, 0)
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
def checkForNeighbors(a, b, matrixB, θ):
    output = ''
    try:
        A = a + coordA[θ] # Cell's 'A' coord plus 'A' distance of neighbor
        B = b + coordB[θ] # Cell's 'B' coord plus 'B' distance of neighbor
        
        # Add output for the log
        output = 'θ(%.2fπ) Bₙ(%d) Aₙ(%d)' % (θ, B, A)
        
        N = matrixB[B][A] # Set neighbor
##        matrixB.index(b).index(a).connect(N) # Connect the neighbor
    except IndexError: # In case the neighbor doesn't exist
        # Add output for the log
        output = output + ' Doesn\'t exist'
        
    print(output)
    
    if θ < 1.75:
        return checkForNeighbors(a, b, matrixB, θ + .25)

    return


# Run the program
main()

