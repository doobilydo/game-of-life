import 'globals.dart' as life;
import 'dart:html';

/// Display statistics.
void displayStats(cycle) {
  // Update stats
  getGridSize().innerHtml = "${life.rows} x ${life.columns}";
  getTotalCycles().innerHtml = "Cycles: ${life.lifeCycles}";
  getLengthOfCycle().innerHtml =
      "Length of cycle: ${life.getDurationInSeconds()} second(s)";
  getCurrentCycle().innerHtml = "Cycle: ${life.cyclesSoFar}";
}

/// Draw the cell.
/// living - true for alive, false for dead.
void drawCell(int x, y, bool living) {
  draw(x * (life.drawWidth + life.border), y * (life.drawWidth + life.border),
      life.drawWidth, life.drawHeight, living);
}

LabelElement getGridSize() {
  return querySelector('#grid-size');
}

LabelElement getTotalCycles() {
  return querySelector('#total-cycles');
}

LabelElement getLengthOfCycle() {
  return querySelector('#length-of-cycle');
}

LabelElement getCurrentCycle() {
  return querySelector('#current-cycle');
}

/// Get the canvas element
CanvasElement getCanvas() {
  return querySelector('#canvas');
}

/// Clear the canvas
void clear() {
  life.context.clearRect(0, 0, life.canvasWidth, life.canvasHeight);
}

void fill() {
  life.context.fill();
}

/// Draw a rectangle
void draw(horizontalPosition, verticalPosition, drawWidth, drawHeight, living) {
  var color;
  if (living) {
    color = life.livingColor;
  } else {
    color = life.deadColor;
  }

  life.context.fillStyle = color;
  life.context
      .fillRect(horizontalPosition, verticalPosition, drawWidth, drawHeight);
}
