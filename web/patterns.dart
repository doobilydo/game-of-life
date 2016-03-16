import 'Cell.dart';
import 'dart:math';
import 'globals.dart' as life;

/// Testing. 4x4 square.
void patternSquare(Cell cell) {
  var dict = {
    '20,20': 1,
    '21,21': 1,
    '21,20': 1,
    '20,21': 1
  };

  String coord = '${cell.coordX},${cell.coordY}';

  if (dict[coord] == 1) {
    cell.state = 1;
  } else {
    cell.state = 0;
  }
  initCorners(cell);
}

/// Initialize a random pattern.
void patternRandom(Cell cell) {
  bool coin = new Random().nextBool();
  if (coin) {
    cell.state = 1;
  } else {
    cell.state = 0;
  }
  initCorners(cell);
}

/// Initialize a blank pattern.
void patternBlank(Cell cell) {
  initCorners(cell);
  var dict = {};

  String coord = '${cell.coordX},${cell.coordY}';

  if (dict[coord] == 1) {
    cell.state = 1;
  } else {
    cell.state = 0;
  }
}

/// Initialize the corners of the canvas as alive.
void initCorners(Cell cell) {
  int x = cell.coordX;
  int y = cell.coordY;
  // Always initialize the corners as living.
  // So we can see them...
  if (x == 0 && y == 0) {
    cell.state = 1;
  }
  if (x == life.columns - 1 && y == 0) {
    cell.state = 1;
  }
  if (x == 0 && y == life.rows - 1) {
    cell.state = 1;
  }
  if (x == life.columns - 1 && y == life.rows - 1) {
    cell.state = 1;
  }
}

/**
 * Named for:
 * pattern
 * D - Dart
 * 4 - Derived from previous pattern 4
 * a - Begin new versioning with Dart code
 *
 * Ends with two nodes.
 */
void patternD4a(Cell cell) {
  var dict = {
    '20,21': 1,
    '21,20': 1,
    '21,24': 1,
    '21,25': 1,
    '21,22': 1,
    '21,21': 1,
    '22,20': 1,
    '23,20': 1, // new
    '23,24': 1,
    '24,21': 1,
    '24,22': 1,
    '24,24': 1,
    '24,23': 1,
    '25,21': 1,
  };

  String coord = '${cell.coordX},${cell.coordY}';

  if (dict[coord] == 1) {
    cell.state = 1;
  } else {
    cell.state = 0;
  }
}

/**
 * Pattern4, increased by 20 on each axis. Things brings it more to the center.
 * Cool beans. 48x100. About 600 cycles.
 * Cake taken.
 *
 * Dart port: Due to bugs through the Python and JavaScript code, I don't
 * think this pattern worked as well as previously thought.
 */
void pattern4b(Cell cell) {
  var dict = {
    '20,21': 1,
    '21,20': 1,
    '21,21': 1,
    '22,20': 1,
    '24,21': 1,
    '24,22': 1,
    '25,21': 1,
    '21,24': 1,
    '21,25': 1,
    '21,22': 1,
    '24,24': 1,
    '23,24': 1,
    '24,23': 1
  };

  String coord = '${cell.coordX},${cell.coordY}';

  if (dict[coord] == 1) {
    cell.state = 1;
  } else {
    cell.state = 0;
  }
}
