import 'globals.dart' as life;
import 'dart:html';

/// Display statistics.
void displayStats(cycle) {
  // Update stats
  num area = life.rows * life.columns;
  getGridSize().innerHtml = "${life.rows} x ${life.columns} (${area})";
  getTotalCycles().innerHtml = "Cycles: ${life.lifeCycles}";
  getLengthOfCycle().innerHtml =
      "Length of cycle: ${life.getDurationInSeconds()} second(s)";
  getCurrentCycle().innerHtml = "Cycle: ${life.cyclesSoFar}";
}

/// Draw the cell.
///
/// living - true for alive, false for dead.
void drawCell(int x, y, bool isAlive) {
  draw(x * (life.drawWidth + life.border), y * (life.drawWidth + life.border),
      life.drawWidth, life.drawHeight, isAlive);
}

/// Get cycleTime element.
LabelElement getCycleTime() {
  return querySelector('#cycleTime');
}

/// Get grid-sie label element.
LabelElement getGridSize() {
  return querySelector('#grid-size');
}

///Get total-cycles label element.
LabelElement getTotalCycles() {
  return querySelector('#total-cycles');
}

/// Get length-of-cycle label element.
LabelElement getLengthOfCycle() {
  return querySelector('#length-of-cycle');
}

/// Get current-cycle label element.
LabelElement getCurrentCycle() {
  return querySelector('#current-cycle');
}

/// Get the canvas element
CanvasElement getCanvas() {
  return querySelector('#canvas');
}

/// Get 2D canvas context.
getContext() {
  return getCanvas().getContext('2d');
}

/// Clear the canvas
void clear() {
  getContext().clearRect(0, 0, life.canvasWidth, life.canvasHeight);
}
//
// void fill() {
//   getContext().fill();
// }

/// Draw a rectangle
void draw(horizontalPosition, verticalPosition, drawWidth, drawHeight, isAlive) {
  var stopwatch = new Stopwatch()..start();
  var color;
  if (isAlive) {
    color = life.livingColor;
  } else {
    color = life.deadColor;
  }

  getContext().fillStyle = color;
  getContext()
      .fillRect(horizontalPosition, verticalPosition, drawWidth, drawHeight);
  stopwatch.stop();
  life.drawTimes.add(stopwatch.elapsedMicroseconds);
}
