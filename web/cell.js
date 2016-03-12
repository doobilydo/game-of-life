// Cell functions

// Check immediate surroundings for existing neighbors.
MAIN.meetTheNeighbors = function(cell) {
    var theta = 0;
    while (theta < 1.75) {
        coordA = {0:+1, 0.25:+1, 0.5:0, 0.75:-1, 1:-1, 1.25:-1, 1.5:0, 1.75:+1};
        coordB = {0:0, 0.25:-1, 0.5:-1, 0.75:-1, 1:0, 1.25:+1, 1.5:+1, 1.75:+1};
        var coord = cell.coordX + ',' + cell.coordY;
        var A = cell.coordX + coordA[theta];
        var B = cell.coordY + coordB[theta];

        if(MAIN.matrix[B] && MAIN.matrix[B][A]) {
            var N = MAIN.matrix[B][A];
            MAIN.connect(cell, N);
        }

        theta = theta + 0.25;
    }
    MAIN.checkNeighbors(cell);
}

// Advance each cell to the next generation.
MAIN.changeGeneration = function(cell) {
    MAIN.grow(cell);
}

MAIN.check = function(cell) {
    MAIN.checkNeighbors(cell);
    cell.nextState = MAIN.tick(cell);
}

// Change to the next state.
MAIN.grow = function(cell) {
    cell.state = cell.nextState;
}

// Connect two cells as neighbors.
MAIN.connect = function(cell, N) {
    if (cell.neighborsList.indexOf(N) === -1) {
        cell.neighborsList.push(N);
    }
}

// Check neighbors for life.
MAIN.checkNeighbors = function(cell) {
    // console.log('function', 'checkNeighbors');
    cell.neighbors = 0;
    // console.log(cell.neighborsList);
    for (var neighbor = 0; neighbor < cell.neighborsList.length; neighbor++) {
        var N = cell.neighborsList[neighbor];

        if (N.state === 1) {
            cell.neighbors = cell.neighbors + 1;
        }
    }
    // console.log(cell.neighbors);
}

// Get the new status of the cell (alive or dead).
// A 'tick' is one life-cycle.
MAIN.tick = function(cell) {
    if(cell.state === 1) {
        if (cell.neighbors < 2) {
            return 0;
        }
        if (cell.neighbors === 2 || cell.neighbors === 3) {
            return 1;
        }
        if (cell.neighbors > 3) {
            return 0;
        }
    } else {
        if (cell.neighbors === 3) {
            return 1;
        } else {
            return 0;
        }
    }
}

// Pattern4, increased by 20 on each axis. Things brings it more to the center.
// Cool beans. 48x100. About 600 cycles.
// Cake taken.
MAIN.pattern4b = function(cell) {
    var dict = {'20,21':1, '21,20':1, '21,21':1, '22,20':1, '24,21':1, '24,22':1,
    '25,21':1, '21,24':1, '21,25':1, '21,22':1, '24,24':1, '23,24':1, '24,23':1};

    var coord = cell.coordX + ',' + cell.coordY;
    // console.log(dict[coord]);
    if (dict[coord]) {
        cell.state = 1;
    } else {
        cell.state = 0;
    }
}
