import 'globals.dart' as life;
import 'dart:html';

/// Display statistics.
void displayStats(cycle) {
  // Update stats
  String stats = '''
      ${life.rows} x ${life.columns}<br>
      Cycles: ${life.lifeCycles},
      Length of cycle: ${life.getDurationInSeconds()} second(s)<br>
      Cycle: ${life.cyclesSoFar}<br>
      Last cycle: ${life.lastCycle}, Living cells: ${life.livingCells}<br>
      ''';

  life.stats.setInnerHtml(stats);
}

/// Draw the cell.
/// living - true for alive, false for dead.
void drawCell(int x, y, bool living) {
  draw(x * (life.drawWidth + life.border), y * (life.drawWidth + life.border),
      life.drawWidth, life.drawHeight, living);
}

/// Get the canvas element
CanvasElement getCanvas() {
  // console.log('function', 'getCanvas');
  return querySelector('#canvas');
}

/// Clear the canvas
void clear() {
  // console.log('function', 'clear');
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
