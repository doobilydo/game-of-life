// http://codepen.io/Lorax/pen/WwvVyZ

var MAIN = MAIN || {};
console.log('starting...');

// Initialize application variables
MAIN.init = function() {
    // console.log('function', 'init');

    // UI variables
    MAIN.context = MAIN.getCanvas().getContext('2d');
    // MAIN.getCanvas().style.width = document.getElementById('main').offsetWidth;
    // MAIN.getCanvas().style.height = document.getElementById('main').offsetHeight;
    MAIN.canvasWidth = MAIN.getCanvas().width;
    MAIN.canvasHeight = MAIN.getCanvas().height;
    MAIN.drawSquare = 5;
    MAIN.drawWidth = MAIN.drawSquare;
    MAIN.drawHeight = MAIN.drawSquare;
    MAIN.border = 1;

    MAIN.stats = document.getElementById('stats');

    // Data variables
    MAIN.cellSquare = 50;
    MAIN.rows = MAIN.cellSquare; // Y
    MAIN.columns = MAIN.cellSquare; // X
    MAIN.lifeCycles = 5;
    MAIN.sleepDuration = 0.2;

    MAIN.livingCells = 0;
    MAIN.lastCycle = 0;

    MAIN.run();

    document.getElementById('start').addEventListener(
        'click',
        function(){
            MAIN.lifeCycle(MAIN.lifeCycles)
        }
        , false
    );
}
window.onload = MAIN.init;

// Run the program
MAIN.run = function() {

    // Center canvas
    var cellsWide = (((MAIN.drawWidth + MAIN.border) * MAIN.columns));
    var cellsHigh = (((MAIN.drawHeight + MAIN.border) * MAIN.rows));
    MAIN.context.translate(
        (MAIN.canvasWidth / 2) - cellsWide / 2,
        (MAIN.canvasHeight / 2) - cellsHigh / 2);

    // Scale the canvas?
    // var scaleSquare = 0.9;
    // var scaleWidth = scaleSquare;
    // var scaleHeight = scaleSquare;
    // MAIN.context.scale(scaleWidth, scaleHeight);

    // Create each cell
    MAIN.initCells();

    // Draw each cell
    for(var y = 0; y < MAIN.rows; y++) {
        for(var x = 0; x < MAIN.columns; x++){

            if(MAIN.matrix[x][y].state === 1) {
                MAIN.drawCell(x, y, true);
                MAIN.livingCells = MAIN.livingCells + 1;
            } else {
                MAIN.drawCell(x, y, false);
            }
        }
    }

    MAIN.displayStats(0);
    // MAIN.lifeCycle(MAIN.lifeCycles);
}

// Execute a lifecycle.
MAIN.lifeCycle = function(cycles) {
    var cycle = 1;

    var display = function() {
        MAIN.displayStats(cycle);

        for(var y = 0; y < MAIN.rows; y++){
            for(var x = 0; x < MAIN.columns; x++){

                if(MAIN.matrix[x][y].state === 1) { // alive
                    MAIN.drawCell(x, y, true);
                    MAIN.livingCells = MAIN.livingCells + 1;
                } else { // dead
                    MAIN.drawCell(x, y, false);
                }
            }
        }
    }
    var refresh = function() {
        console.log("Refresh");
        MAIN.iterateMatrix(MAIN.check);
        MAIN.iterateMatrix(MAIN.changeGeneration);
        MAIN.clear(); // Clear screen
        MAIN.livingCells = 0;
    }

    setInterval(function() {
        if (cycle <= cycles) {
            console.log("Start Cycle: " + cycle);

            refresh();
            display();

            console.log("End Cycle: " + cycle);
        }
        if (MAIN.livingCells === 0) {
            MAIN.lastCycle = cycle;
            cycle = cycles + 1;
        } else {

            cycle++;
        }
    }, MAIN.sleepDuration * 1000);
}

// Initialize naming, neighbors, and states in one iteration.
MAIN.initCells = function() {
    MAIN.matrix = [MAIN.rows];

    for(var y = 0; y < MAIN.rows; y++) {
        MAIN.matrix[y] = [];

        for(var x = 0; x < MAIN.columns; x++) {
            MAIN.matrix[y][x] = {
                state: 1, // Alive (1) or dead (0)
                nextState: 0,
                neighbors: 0, // Living neighbors
                neighborsList: [], // List of neighbors
                name: '(' + x + ',' + y + ')',
                coordX: x,
                coordY: y
            }
            var cell = MAIN.matrix[y][x];

            // Use a user defined pattern
            MAIN.pattern4b(cell);
        }
    }
    // After each cell is created, go around again and meet the neighbors.
    MAIN.iterateMatrix(MAIN.meetTheNeighbors);
}

// Iterate the matrix with the given function.
MAIN.iterateMatrix = function(func) {
    for(var y = 0; y < MAIN.rows; y++){
        for(var x = 0; x < MAIN.columns; x++){
            func(MAIN.matrix[y][x]);
        }
    }
}
