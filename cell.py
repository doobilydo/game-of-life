'''
Cell

Represents the rules and behavior of a cell.
'''

'''
1. Any live cell with fewer than two live neighbours dies,
as if caused by under-population.

2. Any live cell with two or three live neighbours lives
on to the next generation.

3. Any live cell with more than three live neighbours dies,
as if by overcrowding.

4. Any dead cell with exactly three live neighbours becomes a live cell,
as if by reproduction.
'''
class Cell(object):
    '''
    Constructor
    '''
    def __init__(self):
        self.state = 1 # Alive (1) or dead (0)
        self.nextState = 0;
        self.neighbors = 0 # Living neighbors
        self.neighborsList = [] # List of neighbors
        self.name = ''
        self.coord = ''

    '''
    Return full name.
    '''
    @property
    def fullName(self):
        return self.name + ' ' + self.coord


    '''
    Causes this cell to cycle a tick and update its  next status.
    '''
    def check(self):
        self.checkNeighbors()
        self.nextState = self.tick()

    '''
    Change to the next state.
    '''
    def grow(self):
        self.state = self.nextState


    '''
    Get the new status of the cell (alive or dead).
    A 'tick' is one life-cycle.
    '''
    def tick(self):
        # Alive
        if self.state == 1:
            if self.neighbors < 2:
                return 0 # dead
            if self.neighbors == 2 | self.neighbors == 3:
                return 1 # alive
            if self.neighbors > 3:
                return 0 # dead

        # Dead
        else:
            if self.neighbors == 3:
                return 1 # reborn
            else:
                return 0

    '''
    Connect two cells as neighbors.
    '''
    def connect(self, cell):
        try:
            self.neighborsList.index(cell)
        except ValueError:
            self.neighborsList.append(cell)
            self.checkNeighbors()


    '''
    Check neighbors for life.
    '''
    def checkNeighbors(self):
        self.neighbors = 0 # Reset to zero. Fresh check.

        for neighbor in self.neighborsList:
            if neighbor.state == 1:
                self.neighbors = self.neighbors + 1


    '''
    Print the current status of the Cell.
    '''
    def printStatus(self):
        print('Name: %s...State: %d...# of neighbors: %d\n'
        % (self.fullName, self.state, self.neighbors))

'''
A 2-dimensional cell (c) and its neighbors (n)

|n|n|n|
|n|c|n|
|n|n|n|

'''
