library gameoflife;

import 'globals.dart' as life;
import 'ui.dart' as ui;
import 'cell.dart';
import 'dart:html';
import 'dart:async';

/// Links to read:
/// [https://www.dartlang.org/tools/dart2js/]
/// [https://dart-atom.github.io/dartlang/]
/// [https://www.dartlang.org/docs/tutorials/connect-dart-html/#about-css-selectors]
/// [https://www.dartlang.org/docs/tutorials/using-polymer/]
/// /usr/lib/dart/bin/dart2js --out=life.dart.js life.dart
void main() {
  print("main() started....");
  var stopwatch = new Stopwatch()..start();

  init();

  /// Event handler for 'Start' button.
  void clickStart(Event event) {
    life.isCancelled = false;
    lifeCycle(life.lifeCycles);
  }
  querySelector('#start').addEventListener('click', clickStart, false);

  /// Event handler for 'Pause' button.
  void clickPause(Event event) {
    life.isCancelled = true;
  }
  querySelector('#pause').addEventListener('click', clickPause, false);

  /// Event handler for 'Start' button.
  void clickIncrement(Event event) {
    lifeCycle(1);
  }
  querySelector('#increment').addEventListener('click', clickIncrement, false);

  void changeTime(Event event) {
    // querySelector('#cycleTime').innerHtml = event.;
    // life.sleepDuration = num.parse(querySelector('#cycleTime').innerHtml);
    ui.displayStats(life.cyclesSoFar);
  }
  querySelector('#cycleTime')
    ..addEventListener('change', changeTime, false)
    ..innerHtml = life.getDurationInSeconds();

  /// Event handler for 'Pause' button.
  void clickReset(Event event) {
    print('Reset clicked.');
    clickPause(event);
    ui.clear();
    life.cyclesSoFar = 0;
    life.livingCells = 0;
    // Use a user defined pattern
    iterateMatrix(life.initPattern);
    display(0);
  }
  querySelector('#reset').addEventListener('click', clickReset, false);

  // loadDesigner();

  void avg(var list, String type) {
    num total = 0;
    // print("$type: ${list.length}");
    for (num time in list) {
      total = total + time;
    }
    num avg = total / list.length;
    print("$type average: ${avg} microseconds");
  }

  avg(life.drawTimes, "Draw");
  avg(life.meetingTimes, "Meet");
  // print("${life.drawTimes}");
  // print("${life.meetingTimes}");

  stopwatch.stop();
  print("main() complete. ${stopwatch.elapsedMilliseconds} millliseconds");
  return;
}

/// Run the program
void init() {
  // Center canvas
  var cellsWide = (((life.drawWidth + life.border) * life.columns));
  var cellsHigh = (((life.drawHeight + life.border) * life.rows));

// center the canvas
  // ui.getContext().translate((life.canvasWidth / 2) - cellsWide / 2,
  //     (life.canvasHeight / 2) - cellsHigh / 2);

  // Scale the canvas?
  print("Cells wide: ${cellsWide}");
  print("Cells high: ${cellsHigh}");
  print("ratio width: ${life.canvasWidth/cellsWide}");
  print("ratio height: ${life.canvasHeight/cellsHigh}");
  num ratioWidth = (life.canvasWidth / cellsWide);
  num ratioHeight = (life.canvasHeight / cellsHigh);
  num scaleSquare = 0.5;
  num scaleWidth = ratioWidth;
  num scaleHeight = ratioHeight;
  ui.getContext().scale(scaleWidth, scaleHeight);

  // Create each cell
  initCells();
  // Display each initialized cell
  display(0);
}

/// Execute a lifecycle.
void lifeCycle(num cycles) {
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
      life.isCancelled = true;
    }
    if (life.notCancelled() && (life.cyclesSoFar <= cycles)) {
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

  for (num y = 0; y < life.rows; y++) {
    life.matrix.add([]);

    for (num x = 0; x < life.columns; x++) {
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
  var stopwatch = new Stopwatch()..start();
  double theta = 0.0;

  while (theta <= 1.75) {
    num X = cell.coordX + life.coordA[theta];
    num Y = cell.coordY + life.coordB[theta];

    try {
      Cell N = life.matrix[Y][X];
      cell.connect(N);
    } catch (RangeError) {
      // Do nothing. Neighbor doesn't exist.
    }
    theta = theta + 0.25;
  }
  cell.checkNeighbors();

  stopwatch.stop();
  life.meetingTimes.add(stopwatch.elapsedMicroseconds);
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
//
// /// Designer
// void loadDesigner() {
//   print('loading designer...');
//   var stopwatch = new Stopwatch()..start();
//   querySelector('#code').style.display = 'inherit';
//
//   var list = [];
//
//   for (num y = 0; y < life.rows; y++) {
//     TableRowElement row = new TableRowElement();
//     querySelector('#grid').append(row);
//
//     for (num x = 0; x < life.columns; x++) {
//       DivElement checkBox = new DivElement();
//       TableCellElement cell = new TableCellElement();
//       cell.append(checkBox);
//       row.append(cell);
//
//       checkBox.setInnerHtml("$x,$y");
//       checkBox.title = checkBox.innerHtml;
//       checkBox.setAttribute('checked', life.matrix[y][x].state.toString());
//       checkBox.classes.add('designerBox');
//
//       if (checkBox.getAttribute('checked') == "1") {
//         checkBox.style.background = life.livingColor;
//       } else {
//         checkBox.style.background = life.deadColor;
//       }
//
//       void clickDesigner(Event event) {
//         String temp = "";
//         if (checkBox.getAttribute('checked') == "1") {
//           list.remove(checkBox.innerHtml);
//           life.matrix[y][x].state = 0;
//           checkBox.style.background = life.deadColor;
//           checkBox.setAttribute('checked', life.matrix[y][x].state.toString());
//         } else {
//           list.add(checkBox.innerHtml);
//           life.matrix[y][x].state = 1;
//           checkBox.style.background = life.livingColor;
//           checkBox.setAttribute('checked', life.matrix[y][x].state.toString());
//         }
//         list.sort();
//
//         for (String line in list) {
//           if (list.last == line) {
//             // leave out the comma
//             temp = temp + "'$line': 1";
//           } else {
//             temp = temp + "'$line': 1,\n";
//           }
//         }
//         querySelector('#code').setInnerHtml(getText(temp));
//         display(life.cyclesSoFar);
//       }
//       checkBox.addEventListener('click', clickDesigner, false);
//     }
//   }
//   stopwatch.stop();
//   print(
//       'Done loading designer.  ${stopwatch.elapsedMilliseconds} millliseconds');
// }
