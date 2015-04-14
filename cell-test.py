'''
cell.py test
'''
from cell import Cell

cell = Cell()
cell2 = Cell()
cell.connect(cell2)
cell2.connect(cell)
print('Cell state: ', cell.state)
print('Neighbors: ', cell.neighborsList, len(cell.neighborsList))
cell.check()
print('Cell state: ', cell.state)

cell.checkNeighbors()
cell.check()
print('Living neighbors: ', cell.neighbors)


