library gameoflife;

import 'globals.dart' as life;
import 'ui.dart' as ui;

import 'Cell.dart';
import 'dart:html';
import 'dart:async';

/// Links to read:
/// [https://www.dartlang.org/tools/dart2js/]
/// [https://dart-atom.github.io/dartlang/]
/// [https://www.dartlang.org/docs/tutorials/connect-dart-html/#about-css-selectors]
/// [https://www.dartlang.org/docs/tutorials/using-polymer/]
void main() {
  print('Starting...');

  ui.getCanvas().style.width = querySelector('#main').offsetWidth.toString();
  ui.getCanvas().style.height = querySelector('#main').offsetHeight.toString();

  init();

  /// Event handler for 'Start' button.
  void clickStart(Event event) {
    life.cancel = true;
    lifeCycle(life.lifeCycles);
  }
  querySelector('#start').addEventListener('click', clickStart, false);

  /// Event handler for 'Pause' button.
  void clickPause(Event event) {
    life.cancel = false;
  }
  querySelector('#pause').addEventListener('click', clickPause, false);

  /// Event handler for 'Start' button.
  void clickIncrement(Event event) {
    lifeCycle(1);
  }
  querySelector('#increment').addEventListener('click', clickIncrement, false);

// Designer
  Element grid = querySelector('#grid');
  var list = new List<String>();

  for (int y = 0; y < life.rows; y++) {
    for (int x = 0; x < life.columns; x++) {
      CheckboxInputElement checkBox = new CheckboxInputElement();
      checkBox.value = "$x,$y";

      void click(Event event) {
        String temp = "";
        if (checkBox.checked) {
          list.add(checkBox.value);
        } else {
          list.remove(checkBox.value);
        }
        list.sort();

        for (String line in list) {
          if (list.last == line) {
            // leave out the comma
            temp = temp + "$line";
          } else {
            temp = temp + "$line,\n";
          }
        }
        life.text.setInnerHtml(getText(temp));
      }

      checkBox.addEventListener('click', click, false);
      grid.append(checkBox);
    }
  }
  double size = 18.7 * life.rows;
  grid.style.width = "${size}px";

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
  // Display each initialized cell
  display(0);
}

/// Execute a lifecycle.
void lifeCycle(int cycles) {
  void refresh() {
    /// Check for living neighbors
    void check(Cell cell) {
      cell.check();
    }

    /// Advance to the next state.
    void grow(Cell cell) {
      cell.grow();
    }
    iterateMatrix(check);
    iterateMatrix(grow);
    ui.clear(); // Clear screen
    life.livingCells = 0;
  }

  runCycle() {
    refresh(); // Change state
    display(life.cyclesSoFar); // Display the new state

    life.cyclesSoFar++;
    if (life.livingCells == 0) {
      life.cancel = true;
    }
    if ((life.cancel) && (life.cyclesSoFar <= cycles)) {
      new Future.delayed(life.sleepDuration, () {
        runCycle();
      });
    }
  }
  // Only allow the maximum number of life cycles.
  if (life.cyclesSoFar <= life.lifeCycles) {
    new Future.delayed(life.sleepDuration, () {
      runCycle();
    });
  }
}

/// Initialize naming, neighbors, and states in one iteration.
void initCells() {
  Cell cell;

  for (int y = 0; y < life.rows; y++) {
    life.matrix.add(new List<Cell>());

    for (int x = 0; x < life.columns; x++) {
      life.matrix[y].add(new Cell());
      cell = life.matrix[y][x];
      cell.coordX = x;
      cell.coordY = y;

      // Use a user defined pattern
      life.initPattern(cell);
    }
  }
  // After each cell is created, go around again and meet the neighbors.
  iterateMatrix(meetTheNeighbors);
}

/// Check immediate surroundings for existing neighbors.
void meetTheNeighbors(Cell cell) {
  double theta = 0.0;

  while (theta < 1.75) {
    int X = cell.coordX + life.coordA[theta];
    int Y = cell.coordY + life.coordB[theta];

    try {
      Cell N = life.matrix[Y][X];
      cell.connect(N);
    } catch (RangeError) {
      // Do nothing. Neighbor doesn't exist.
    }
    theta = theta + 0.25;
  }
  cell.checkNeighbors();
}

/// Iterate the matrix with the given function.
void iterateMatrix(Function func) {
  for (var row in life.matrix) {
    for (Cell cell in row) {
      func(cell);
    }
  }
}

/// Draw cells to canvas and count living versus dead.
void drawCells(Cell cell) {
  if (cell.state == 1) {
    // alive
    ui.drawCell(cell.coordX, cell.coordY, true);
    life.livingCells = life.livingCells + 1;
  } else {
    // dead
    ui.drawCell(cell.coordX, cell.coordY, false);
  }
}

/// Draw cells, update and display stats.
void display(cycle) {
  iterateMatrix(drawCells);
  ui.displayStats(cycle);
}

String getText(String input) {
  return '''
var coordMap = {
${input}
};
  ''';
}