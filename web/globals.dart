import 'ui.dart' as ui;
import 'dart:html';
import 'Cell.dart';
import 'patterns.dart' as pattern;

// UI variables
var context = ui.getCanvas().getContext('2d');

// canvas properties
var canvasWidth = ui.getCanvas().width;
var canvasHeight = ui.getCanvas().height;
int drawSquare = 10;
int drawWidth = drawSquare;
int drawHeight = drawSquare;
int border = 1;
String livingColor = 'orange';
String deadColor = 'black';

Element stats = querySelector('#stats');

// Data variables
int cellSquare = 50;
int rows = cellSquare; // Y
int columns = cellSquare; // X
int lifeCycles = 1000;
int cyclesSoFar = 0;
final sleepDuration = const Duration(milliseconds: 50);

var initPattern = pattern.patternD4a;

int livingCells = 0;
int lastCycle = 0;
bool cancel = false;

var matrix = new List<Cell>();

/// Return the sleep duration in seconds.
String getDurationInSeconds() {
  return sleepDuration.inMilliseconds / 1000.0;
}

// X coordinate for rotating around a cell.
var coordA = {
  0: 1,
  0.25: 1,
  0.5: 0,
  0.75: -1,
  1: -1,
  1.25: -1,
  1.5: 0,
  1.75: 1
};
// Y coordinate for rotating around a cell.
var coordB = {
  0: 0,
  0.25: -1,
  0.5: -1,
  0.75: -1,
  1: 0,
  1.25: 1,
  1.5: 1,
  1.75: 1
};
