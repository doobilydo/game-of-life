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
        self.state = 0 # Alive (true) or dead (false)
        self.neighbors = 0 # Living neighbors
        self.neighborsList = [] # List of neighbors

    '''
    Causes this cell to cycle a tick and update its status.
    '''
    def check(self):
        state = self.tick()

    
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

        return 0

    '''
    Connect two cells as neighbors.
    '''
    def connect(self, cell):
        try:
            self.neighborsList.index(cell)
        except ValueError:
            self.neighborsList.append(cell)
            cell.connect(self)

    '''
    Check neighbors for life.
    '''
    def checkNeighbors(self):
        for neighbor in self.neighborsList:
            if neighbor.state == 1:
                self.neighbors = self.neighbors + 1
                # Increment for living neighbor
            elif neighbor.state == 0:
                if self.neighbors > 0:
                    self.neighbors = self.neighbors - 1
                    # Decrement for dead neighbor


        
'''
A 2-dimensional cell (c) and its neighbors (n)

|n|n|n|
|n|c|n|
|n|n|n|

'''
