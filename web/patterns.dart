import 'Cell.dart';

// Pattern4, increased by 20 on each axis. Things brings it more to the center.
// Cool beans. 48x100. About 600 cycles.
// Cake taken.
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
