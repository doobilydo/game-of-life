import 'ui.dart' as ui;
import 'patterns.dart' as pattern;

// canvas properties
var canvasWidth = ui.getCanvas().width;
var canvasHeight = ui.getCanvas().height;
num drawSquare = 5;
num drawWidth = drawSquare;
num drawHeight = drawSquare;
num border = 1;
String livingColor = 'orange';
String deadColor = 'black';

// Data variables
num cellSquare = 120;
num rows = cellSquare; // Y
num columns = cellSquare; // X
num lifeCycles = 10000;
var sleepDuration = const Duration(milliseconds: 30);

// var initPattern = pattern.patternBlank;
var initPattern = pattern.patternRandom; // Change initial pattern

num livingCells = 0;
num lastCycle = 0;
num cyclesSoFar = 0;
bool isCancelled;
bool notCancelled() => !isCancelled;

/// List
var matrix = [];

// Performance stats
var drawTimes = [];
var meetingTimes = [];

/// Return the sleep duration in seconds.
String getDurationInSeconds() {
  return sleepDuration.inMilliseconds / 1000.0;
}

/// X coordinate for rotating around a cell.
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

/// Y coordinate for rotating around a cell.
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
