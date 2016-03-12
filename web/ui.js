
// Display statistics.
MAIN.displayStats = function(cycle) {
    // Update stats
    var stats = MAIN.rows + " x " + MAIN.columns + "<br>"
    + "Cycles: " + parseInt(MAIN.lifeCycles) + ", Length of cycle: "
    + MAIN.sleepDuration + " second(s)<br>"
    + "Cycle: " + parseInt(cycle) + "<br>"
    + "Last cycle: " + MAIN.lastCycle + ", Living cells: " + MAIN.livingCells + "<br>";

    MAIN.stats.innerHTML = stats;
}

// Draw the cell.
// living - true for alive, false for dead.
MAIN.drawCell = function(x, y, living) {
    MAIN.draw(
      x * (MAIN.drawWidth + MAIN.border),
      y * (MAIN.drawWidth + MAIN.border),
      MAIN.drawWidth, MAIN.drawHeight, living);
}

// Get the canvas element
MAIN.getCanvas = function() {
  // console.log('function', 'getCanvas');
  return document.getElementById('canvas');
}

// Clear the canvas
MAIN.clear = function() {
  // console.log('function', 'clear');
  MAIN.context.clearRect(0, 0, MAIN.canvasWidth, MAIN.canvasHeight);
}

// Draw a rectangle
MAIN.draw = function(
    horizontalPosition,
    verticalPosition,
    drawWidth,
    drawHeight,
    living) {

    var color;
    if (living) {
      color = 'orange';
    } else {
      color = 'black';
    }

    MAIN.context.fillStyle = color;
    MAIN.context.fillRect (horizontalPosition, verticalPosition,
        drawWidth, drawHeight);
}
