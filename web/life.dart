library gameoflife;

import 'globals.dart' as life;
import 'ui.dart' as ui;
import 'patterns.dart' as pattern;
import 'Cell.dart';
import 'dart:html';

/// Links to read:
/// [https://www.dartlang.org/tools/dart2js/]
/// [https://dart-atom.github.io/dartlang/]
/// [https://www.dartlang.org/docs/tutorials/connect-dart-html/#about-css-selectors]
/// [https://www.dartlang.org/docs/tutorials/using-polymer/]
///

void main() {
  print('Starting...');

  ui.getCanvas().style.width =
      document.getElementById('main').offsetWidth.toString();
  ui.getCanvas().style.height =
      document.getElementById('main').offsetHeight.toString();

  init();

  /// Event handler for 'Start' button.
  void clickStart(Event event) {
    lifeCycle(life.lifeCycles);
  }
  querySelector('start').addEventListener('click', clickStart, false);

  return;
}

/// Run the program
void init() {
  // Center canvas
  var cellsWide = (((life.drawWidth + life.border) * life.columns));
  var cellsHigh = (((life.drawHeight + life.border) * life.rows));
  life.context.translate((life.canvasWidth / 2) - cellsWide / 2,
      (life.canvasHeight / 2) - cellsHigh / 2);

  // Scale the canvas?
  // var scaleSquare = 0.9;
  // var scaleWidth = scaleSquare;
  // var scaleHeight = scaleSquare;
  // context.scale(scaleWidth, scaleHeight);

  // Create each cell
  initCells();

  /// Draw each cell
  for (int y = 0; y < life.rows; y++) {
    for (int x = 0; x < life.columns; x++) {
      if (life.matrix[x][y].state == 1) {
        ui.drawCell(x, y, true);
        life.livingCells = life.livingCells + 1;
      } else {
        ui.drawCell(x, y, false);
      }
    }
  }

  ui.displayStats(0);
  // lifeCycle(lifeCycles);
}

/// Execute a lifecycle.
void lifeCycle(int cycles) {
  var cycle = 1;

  void display() {
    ui.displayStats(cycle);

    for (var y = 0; y < life.rows; y++) {
      for (var x = 0; x < life.columns; x++) {
        if (life.matrix[x][y].state == 1) {
          // alive
          ui.drawCell(x, y, true);
          life.livingCells = life.livingCells + 1;
        } else {
          // dead
          ui.drawCell(x, y, false);
        }
      }
    }
  }

  void refresh() {
    // console.log("Refresh");
    // iterateMatrix(life.check);
    // iterateMatrix(life.changeGeneration);
    ui.clear(); // Clear screen
    life.livingCells = 0;
  }

  // setInterval(function() {
  //     if (cycle <= cycles) {
  //         console.log("Start Cycle: " + cycle);
  //
  //         refresh();
  //         display();
  //
  //         console.log("End Cycle: " + cycle);
  //     }
  //     if (life.livingCells === 0) {
  //         life.lastCycle = cycle;
  //         cycle = cycles + 1;
  //     } else {
  //
  //         cycle++;
  //     }
  // }, life.sleepDuration * 1000);
}

/// Initialize naming, neighbors, and states in one iteration.
void initCells() {
  life.matrix = [life.rows];
  Cell cell;

  for (int y = 0; y < life.rows; y++) {
    life.matrix[y] = [];

    for (int x = 0; x < life.columns; x++) {
      life.matrix[y][x] = new Cell();
      cell = life.matrix[y][x];

      // Use a user defined pattern
      pattern.pattern4b(cell);
    }
  }
  // After each cell is created, go around again and meet the neighbors.
  // iterateMatrix(meetTheNeighbors(cell));
}

/// Check immediate surroundings for existing neighbors.
void meetTheNeighbors(Cell cell) {
  double theta = 0.0;

  while (theta < 1.75) {
    // String coord = this.coordX + ',' + this.coordY;
    int X = cell.coordX + life.coordA[theta];
    int Y = cell.coordY + life.coordB[theta];

    if (life.matrix[Y] && life.matrix[Y][X]) {
      Cell N = life.matrix[Y][X];
      cell.connect(N);
    }

    theta = theta + 0.25;
  }
  cell.checkNeighbors();
}

/// Iterate the matrix with the given function.
void iterateMatrix(Function func) {
  for (int y = 0; y < life.rows; y++) {
    for (int x = 0; x < life.columns; x++) {
      func(life.matrix[y][x]);
    }
  }
}
